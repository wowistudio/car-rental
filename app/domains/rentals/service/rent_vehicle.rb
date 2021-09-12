module Rentals
  module Service
    class RentVehicle
      NeedsPledge = Class.new(StandardError)
      HasCurrentRentals = Class.new(StandardError)

      def initialize(member, params)
        @member = member
        @params = params
      end

      def call
        raise HasCurrentRentals if unfinished_rentals.any?

        rental

        raise NeedsPledge if needs_pledge?

        rental
      end

      private

      attr_reader :member, :params

      def rental
        @rental ||= Rental.create(
          vehicle: vehicle,
          member: member,
          payment: payment,
          state: rental_state,
          return_at: Time.current + params[:hours].hours
        )
      end

      def rental_state
        needs_pledge? ? Rental.states[:pending] : Rental.states[:rented]
      end

      def payment
        Payment.create
      end

      def vehicle
        Vehicle.find_by(uid: params[:uid])
      end

      def unfinished_rentals
        member.rentals.where.not(state: Rental.states[:finished])
      end

      def needs_pledge?
        Prices::Service::PledgeAmount.new(member, vehicle).call.positive?
      end
    end
  end
end
