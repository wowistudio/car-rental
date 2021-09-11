module Prices
  module Service
    class Pledge
      def initialize(member, vehicle)
        @member = member
        @vehicle = vehicle
      end

      def call
        return 0 if member.gold?
        return 100 if %w[L M N].include?(vehicle.uid)

        300
      end

      private

      attr_reader :member, :vehicle
    end
  end
end
