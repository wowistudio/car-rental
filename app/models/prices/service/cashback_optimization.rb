module Prices
  module Service
    class CashbackOptimization
      def initialize(amount)
        @amount = amount
      end

      def call
        amount
      end

      private

      attr_reader :amount

      def supported
        [50, 20, 10, 5, 2, 1, 0.5, 0.2]
      end
    end
  end
end
