module Rentals
  module Service
    class RentVehicle
      def initialize(member, params)
        @member = member
        @params = params
      end

      def call
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
        Vehicle.find(params[:id])
      end
    end
  end
end
