class AtmMachine < ApplicationRecord
  has_many :banknotes

  def balance
    self.banknotes.inject(0) { |sum, i| sum + i.denomination * i.quantity }
  end
end
