module Prices
  module Service
    class CashbackOptimization
      def initialize(amount)
        @amount = amount
      end

      def call
        cashbacks.to_h
      end

      private

      attr_reader :amount

      def cashbacks
        supported_values.map do |value|
          times = (amount / value).floor
          @amount = amount - (times * value)
          [value, times]
        end
      end

      def supported_values
        [50, 20, 10, 5, 2, 1, 0.5, 0.2]
      end
    end
  end
end
