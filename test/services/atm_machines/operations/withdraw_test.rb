require 'test_helper'

class AtmMachines::Operations::WithdrawTest < ActiveSupport::TestCase
  def subject(amount)
    AtmMachines::Operations::Withdraw.new(params(amount)).perform
  end

  def params(amount)
    {
      id: atm.id,
      amount: amount
    }
  end

  def atm
    atm_machines(:one)
  end

  test "#perform returns hash with banknotes count" do
    assert_equal subject(51), { 50 => 1, 1 => 1 }
  end

  test "#perform returns hash with error" do
    assert_raises(AtmMachines::Operations::Withdraw::NoFunds) do
      subject(1098)
    end
  end

  test "#perform update balance" do
    subject(51)
    assert atm.balance, 49
  end
end
