module AtmMachines
  module Operations
    class Withdraw < Base
      class NoFunds < StandardError; end

      def initialize(params)
        @amount = params[:amount]
        @banknotes = Hash.new(0)
        super
      end

      def perform
        find_available_banknotes
        raise NoFunds if @amount != 0

        update_banknote_quantities(@banknotes) do |banknote, quantity|
          banknote.update!(quantity: banknote.quantity - quantity)
        end
        @banknotes
      end

      private

      def find_available_banknotes
        # this algorithm will not work if we add another denomination (3 as example)
        notes = @atm.banknotes.order(denomination: :desc)
        notes.each do |note|
          num = @amount / note.denomination
          next if note.quantity == 0 || num == 0

          allowed_quantity = (note.quantity - num) > 0 ? num : note.quantity
          @amount -= allowed_quantity * note.denomination
          @banknotes[note.denomination] += allowed_quantity
        end
      end
    end
  end
end
