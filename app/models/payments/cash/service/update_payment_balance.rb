module Payments
  module Cash
    module Service
      class UpdatePaymentBalance
        def initialize(member, params)
          @member = member
          @params = params
        end

        def call
          update_payment
          mark_rental_finished unless rental.payment.balance.negative?

          {
            rental_state: rental.reload.state,
            payment_balance: rental.payment.balance
          }
        end

        private

        attr_reader :member, :params

        def mark_rental_finished
          rental.update(state: 'finished')
        end

        def update_payment
          rental.payment.add_balance(params[:amount])
        end

        def rental
          @rental ||= Rental.find_by(member_id: member.id, state: 'payment')
        end
      end
    end
  end
end
