module Payments
  module Service
    class UpdatePaymentBalance
      NoPendingPayment = Class.new(StandardError)

      def initialize(member, params)
        @member = member
        @params = params
      end

      def call
        raise NoPendingPayment if pending_payments.empty?

        case params[:payment_method]
        when 'CASH'
          Payments::Cash::Service::UpdatePaymentBalance.new(member, params).call
        end
      end

      private

      attr_reader :member, :params

      def pending_payments
        member.rentals.where(state: Rental.states[:payment])
      end
    end
  end
end
