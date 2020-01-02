module AtmMachines
  module Operations
    class Base
      attr_reader :params

      def initialize(params)
        @params = params
        @atm = AtmMachine.find(params[:id])
      end

      private

      def update_banknote_quantities(notes)
        ActiveRecord::Base.transaction do
          notes.each do |note, quantity|
            banknote = Banknote.lock.find_or_initialize_by(denomination: note, atm_machine: @atm)
            yield banknote, quantity
          end
        end
      end
    end
  end
end
