class Member < ApplicationRecord
  has_many :rentals

  enum membership: { gold: 'gold', regular: 'regular' }
end
