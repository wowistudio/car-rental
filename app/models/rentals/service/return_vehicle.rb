module Rentals
  module Service
    class ReturnVehicle
      def initialize(member)
        @member = member
      end

      def call
        update_rental
        set_amount_to_pay

        rental.payment
      end

      private

      attr_reader :member

      def update_rental
        rental.update(returned_at: Time.current, state: 'payment')
      end

      def set_amount_to_pay
        rental.payment.update(balance: -total_price_rounded)
      end

      def total_price_rounded
        Prices::Service::RoundPrice.new(
          Prices::Service::TotalPrice.new(
            rental
          ).call
        ).call
      end

      def rental
        @rental ||= Rental.find_by(member_id: member.id, state: 'rented')
      end
    end
  end
end
