class CreateAtmMachines < ActiveRecord::Migration[5.2]
  def change
    create_table :atm_machines do |t|
      t.integer :balance, default: 0

      t.timestamps
    end
  end
end
