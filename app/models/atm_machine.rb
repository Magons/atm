class AtmMachine < ApplicationRecord
  NOTES = %w(50 25 10 5 2 1)

  has_many :banknotes
end
