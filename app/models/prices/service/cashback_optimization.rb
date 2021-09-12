module Prices
  module Service
    class CashbackOptimization
      SUPPORTED_AMOUNTS = [50, 20, 10, 5, 2, 1, 0.5, 0.2]

      def initialize(amount)
        @initial = Prices::Service::RoundPrice.new(amount).call
        @amount = @initial
      end

      def call
        {
          cashback: @initial,
          amounts: amounts.to_h
        }
      end

      private

      attr_reader :amount

      def amounts
        SUPPORTED_AMOUNTS.map do |value|
          times = (amount / value).floor
          @amount = (amount - (times * value)).round(2)
          [value, times]
        end
      end
    end
  end
end
