class Payment < ApplicationRecord
  belongs_to :rental

  def add_balance(balance_addition)
    update(balance: balance + balance_addition)
  end
end
