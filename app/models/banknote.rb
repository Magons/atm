class Banknote < ApplicationRecord
  NOTES = %w(50 25 10 5 2 1)

  belongs_to :atm_machine

  validates :denomination, inclusion: { in: NOTES.map(&:to_i) }, uniqueness: true
end
