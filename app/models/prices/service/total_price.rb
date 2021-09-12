module Prices
  module Service
    class TotalPrice
      MINIMUM_RENTAL_HOURS = 4
      SECONDS_PER_HOUR = 3600

      def initialize(rental)
        @rental = rental
      end

      def call
        hourly_rate * time_rented_adjusted
      end

      private

      attr_reader :rental

      def time_rented_adjusted
        [MINIMUM_RENTAL_HOURS, time_rented].max
      end

      def time_rented
        (@rental.return_at - @rental.created_at) / SECONDS_PER_HOUR
      end

      def hourly_rate
        Prices::Service::HourlyRate.new(rental.member, rental.vehicle).call
      end
    end
  end
end
