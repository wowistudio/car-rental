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
          raise UnsupportedAmount unless amount_valid?

          updated_balance = add_pledge

          {
            rental_state: rental.reload.state,
            pledge_remaining: pledge_amount - updated_balance
          }
        end

        private

        attr_reader :member, :params

        def amount_valid?
          Prices::Service::CashbackOptimization.new(params[:amount]).amount_valid?
        end

        def mark_rental_rented
          rental.update(state: Rental.states[:rented])
        end

        def pledge_amount
          @pledge_amount ||= Prices::Service::PledgeAmount.new(member, rental.vehicle).call
        end

        def add_pledge
          updated_balance, added_amount = rental.payment.add_balance(params[:amount])
          mark_rental_rented unless (updated_balance - pledge_amount).negative?
          updated_balance
        end

        def rental
          @rental ||= Rental.find_by(member_id: member.id, state: Rental.states[:pending])
        end
      end
    end
  end
end
