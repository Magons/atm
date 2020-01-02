class CreateBanknotes < ActiveRecord::Migration[5.2]
  def change
    create_table :banknotes do |t|
      t.integer :denomination
      t.integer :quantity
      t.belongs_to :atm_machine, foreign_key: true
      t.index :denomination, unique: true

      t.timestamps
    end
  end
end
