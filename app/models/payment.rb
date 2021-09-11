class Payment < ApplicationRecord
  belongs_to :rental

  def add_balance(balance_addition)
    self.update(balance: self.balance + balance_addition)
  end
end
