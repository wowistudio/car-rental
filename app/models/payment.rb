class Payment < ApplicationRecord
  belongs_to :rental

  def add_balance(balance_addition)
    update(balance: (balance + balance_addition).round(2))
    [balance, balance_addition]
  end

  def eject_balance
    ejected_balance = balance
    update(balance: 0)
    ejected_balance
  end
end
