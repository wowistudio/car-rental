class Rental < ApplicationRecord
  belongs_to :vehicle
  belongs_to :member

  enum state: { pending: 'pending', rented: 'rented', returned: 'returned' }
end
