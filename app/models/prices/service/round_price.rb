module Prices
  module Service
    class RoundPrice
      def initialize(price)
        @price = price
      end

      def call
        price.floor + rounded_remainder
      end

      private

      attr_reader :price

      def rounded_remainder
        roundup_map
          .select { |key, _| key[:min] <= remainder && key[:max] >= remainder }
          .values[0]
          .to_f
      end

      def remainder
        (price - price.floor).round(2)
      end

      def roundup_map
        {
          { min: 0.01, max: 0.20 } => 0.20,
          { min: 0.21, max: 0.40 } => 0.40,
          { min: 0.41, max: 0.50 } => 0.50,
          { min: 0.51, max: 0.60 } => 0.60,
          { min: 0.61, max: 0.70 } => 0.70,
          { min: 0.71, max: 0.80 } => 0.80,
          { min: 0.81, max: 0.90 } => 0.90,
          { min: 0.91, max: 0.99 } => 1.00
        }
      end
    end
  end
end
