module Payments
  module Service
    class UpdatePaymentBalance
      def initialize(member, params)
        @member = member
        @params = params
      end

      def call
        case params[:payment_method]
        when 'CASH'
          Payments::Cash::Service::UpdatePaymentBalance.new(member, params).call
        end
      end

      private

      attr_reader :member, :params
    end
  end
end
