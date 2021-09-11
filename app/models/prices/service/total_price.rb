module Prices
  module Service
    class TotalPrice
      def initialize(rental)
        @rental = rental
      end

      def call
        hourly_rate * time_rented
      end

      private

      attr_reader :rental

      def time_rented
        (@rental.returned_at - @rental.created_at) / 3600
      end

      def hourly_rate
        Prices::Service::HourlyRate.new(rental.member, rental.vehicle).call
      end
    end
  end
end
