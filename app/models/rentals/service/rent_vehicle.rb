module Rentals
  module Service
    class RentVehicle
      HasCurrentRentals = Class.new(StandardError)

      def initialize(member, params)
        @member = member
        @params = params
      end

      def call
        raise HasCurrentRentals if unfinished_rentals.any?

        rental
      end

      private

      attr_reader :member, :params

      def rental
        Rental.create(
          vehicle: vehicle,
          member: member,
          payment: payment,
          state: Rental.states[:rented],
          return_at: Time.current + params[:hours].hours
        )
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
    end
  end
end
