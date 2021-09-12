module Payments
  module Cash
    module Service
      class UpdatePaymentBalance
        UnsupportedAmount = Class.new(StandardError)

        def initialize(member, params)
          @member = member
          @params = params
        end

        def call
          raise UnsupportedAmount unless amount_valid?

          update_payment
          mark_rental_finished if rental.payment.balance.zero?
          mark_rental_cashback if rental.payment.balance.positive?

          {
            rental_state: rental.reload.state,
            payment_remaining: -rental.payment.balance
          }
        end

        private

        attr_reader :member, :params

        def amount_valid?
          Prices::Service::CashbackOptimization.new(params[:amount]).amount_valid?
        end

        def mark_rental_finished
          rental.update(state: Rental.states[:finished])
        end

        def mark_rental_cashback
          rental.update(state: Rental.states[:cashback])
        end

        def update_payment
          rental.payment.add_balance(params[:amount])
        end

        def rental
          @rental ||= Rental.find_by(member_id: member.id, state: Rental.states[:payment])
        end
      end
    end
  end
end
