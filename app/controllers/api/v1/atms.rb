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
              AtmMachine::NOTES.each do |note|
                optional note.to_sym, type: Integer, values: ->(v) { v > 0 }
              end
              # optional :'50', type: Integer, values: ->(v) { v > 0 }
              # optional :'25', type: Integer, values: ->(v) { v > 0 }
              # optional :'10', type: Integer, values: ->(v) { v > 0 }
              # optional :'5', type: Integer, values: ->(v) { v > 0 }
              # optional :'2', type: Integer, values: ->(v) { v > 0 }
              # optional :'1', type: Integer, values: ->(v) { v > 0 }
            end
          end

          post :insert do
            AtmMachines::Operations::Insert.new(permitted_params).insert
            status 204
          end

          desc "Withdrawing of amount"
          params do
            requires :id, type: String, desc: "ID of the atm machine"
            requires :amount, type: Integer, desc: 'Amount which needs to withdraw'
          end
          post :withdraw do
            result = AtmMachines::Operations::Withdraw.new(permitted_params).withdraw

            present result, with: Api::V1::Entities::ATMWithdrawal # grape-enity
          end
        end
      end
    end
  end
end
