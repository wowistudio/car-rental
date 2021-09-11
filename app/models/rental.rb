class Rental < ApplicationRecord
  belongs_to :vehicle
  belongs_to :member
  has_one :payment, dependent: :nullify

  enum state: { pending: 'pending', rented: 'rented', returned: 'returned' }
end
