module Prices
  module Service
    class CashbackOptimization
      SUPPORTED_AMOUNTS = [50, 20, 10, 5, 2, 1, 0.5, 0.2]

      def initialize(amount)
        @amount = Prices::Service::RoundPrice.new(amount).call
      end

      def call
        cashbacks.to_h
      end

      private

      attr_reader :amount

      def cashbacks
        SUPPORTED_AMOUNTS.map do |value|
          times = (amount / value).floor
          @amount = amount - (times * value)
          [value, times]
        end
      end
    end
  end
end
