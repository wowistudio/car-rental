module Prices
  module Service
    class HourlyRate
      def initialize(member, vehicle)
        @member = member
        @vehicle = vehicle
      end

      def call
        prices[key]
      end

      private

      attr_reader :member, :vehicle

      def key
        [member.membership, vehicle.uid].join('.')
      end

      def prices
        {
          'gold.M1': 8.75,
          'regular.M1': 9.45
        }.with_indifferent_access
      end
    end
  end
end
