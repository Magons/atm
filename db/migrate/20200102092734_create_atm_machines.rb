class CreateAtmMachines < ActiveRecord::Migration[5.2]
  def change
    create_table :atm_machines do |t|
      t.timestamps
    end
  end
end
