require 'test_helper'

class AtmMachines::Operations::InsertTest < ActiveSupport::TestCase
  def subject(params)
    AtmMachines::Operations::Insert.new(params).perform
  end

  def params
    {
      id: atm.id,
      banknotes: {
        '50' => 2
      }
    }
  end

  def atm
    atm_machines(:one)
  end

  def fifty_banknote
    banknotes(:fifty)
  end

  test "#perform update banknote wit 50 demention" do
    assert_difference('fifty_banknote.reload.quantity', 2) do
      subject(params)
    end
  end

  test "#perform update balance" do
    subject(params)
    assert atm.balance, 193
  end
end
