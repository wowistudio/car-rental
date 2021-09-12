module Payments
  module Service
    class AddPledge
      NoPendingPledge = Class.new(StandardError)

      def initialize(member, params)
        @member = member
        @params = params
      end

      def call
        raise NoPendingPledge if rentals_pledge.empty?

        case params[:payment_method]
        when 'CASH'
          Payments::Cash::Service::AddPledge.new(member, params).call
        end
      end

      private

      attr_reader :member, :params

      def rentals_pledge
        member.rentals.where(state: Rental.states[:pledging])
      end
    end
  end
end
