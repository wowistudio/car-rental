class Rental < ApplicationRecord
  belongs_to :vehicle
  belongs_to :member
  has_one :payment, dependent: :destroy

  enum state: {
    pending: 'pending',
    rented: 'rented',
    payment: 'payment',
    cashback: 'cashback',
    finished: 'finished'
  }
end
