class Member < ApplicationRecord
  enum membership: { gold: 'gold', regular: 'regular' }
end
