module Rentals
  module Service
    class ReturnVehicle
      def initialize(member, params)
        @member = member
        @params = params
      end

      def call
        update_rental
        set_amount_to_pay

        rental.payment
      end

      private

      attr_reader :member, :params

      def returned_at
        Time.parse(params[:return_at]) || Time.current
      end

      def update_rental
        rental.update(returned_at: returned_at, state: 'payment')
      end

      def set_amount_to_pay
        rental.payment.update(balance: -total_price)
      end

      def total_price
        Prices::Service::TotalPrice.new(rental).call
      end

      def rental
        @rental ||= Rental.find_by(member_id: member.id, state: 'rented')
      end
    end
  end
end
