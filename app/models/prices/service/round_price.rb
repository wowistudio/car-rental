module Prices
  module Service
    class RoundPrice
      def initialize(price)
        @price = price
      end

      def call
        price.round(2)
      end

      private

      attr_reader :price
    end
  end
end
