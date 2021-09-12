class Member < ApplicationRecord
  has_many :rentals, dependent: :nullify

  enum membership: { gold: 'gold', regular: 'regular' }
end
