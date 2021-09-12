module Payments
  module Cash
    module Service
      class AddPledge
        UnsupportedAmount = Class.new(StandardError)

        def initialize(member, params)
          @member = member
          @params = params
        end

        def call
          raise UnsupportedAmount if unsupported_amount?

          add_pledge_amount
          mark_rental_rented unless pledge_amount_remaining.positive?

          {
            rental_state: rental.reload.state,
            pledge_remaining: pledge_amount_remaining
          }
        end

        private

        attr_reader :member, :params

        def unsupported_amount?
          Prices::Service::CashbackOptimization::SUPPORTED_AMOUNTS.exclude?(params[:amount])
        end

        def mark_rental_rented
          rental.update(state: Rental.states[:rented])
        end

        def pledge_amount_remaining
          total_pledge_amount - rental.reload.payment.balance
        end

        def add_pledge_amount
          rental.payment.add_balance(params[:amount])
        end

        def total_pledge_amount
          Prices::Service::PledgeAmount.new(member, rental.vehicle).call
        end

        def rental
          @rental ||= Rental.find_by(member_id: member.id, state: Rental.states[:pledging])
        end
      end
    end
  end
end
