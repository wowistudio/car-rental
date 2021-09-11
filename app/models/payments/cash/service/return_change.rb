module Payments
  module Cash
    module Service
      class ReturnChange
        def initialize(member)
          @member = member
        end

        def call
          cashback = Prices::Service::CashbackOptimization.new(rental.payment.balance).call

          mark_rental_finished
          update_payment

          cashback
        end

        private

        attr_reader :member

        def mark_rental_finished
          rental.update(state: 'finished')
        end

        def update_payment
          rental.payment.update(balance: 0)
        end

        def rental
          @rental ||= Rental.find_by(member_id: member.id, state: 'cashback')
        end
      end
    end
  end
end
