module API
  module V1
    class Atms < Grape::API
      include API::V1::Defaults

      resource :atms do
        route_param :id do
          desc "Inserting money"
          params do
            requires :id, type: String, desc: "ID of the atm machine"
            requires :banknotes, type: Hash do
              Banknote::NOTES.each do |note|
                optional note.to_sym, type: Integer, values: ->(v) { v > 0 }
              end
            end
          end

          post :insert do
            AtmMachines::Operations::Insert.new(permitted_params).perform
            status 204
          end

          desc "Withdrawing of amount"
          params do
            requires :id, type: String, desc: "ID of the atm machine"
            requires :amount, type: Integer, desc: 'Amount which needs to withdraw'
          end
          post :withdraw do
            AtmMachines::Operations::Withdraw.new(permitted_params).perform
          rescue AtmMachines::Operations::Withdraw::NoFunds
            error!('No Funds!', 400)
          end
        end
      end
    end
  end
end
