module AtmMachines
  module Operations
    class Insert < Base
      def perform
        update_banknote_quantities(banknotes_params) do |banknote, quantity|
          banknote.update!(quantity: banknote.quantity + quantity)
        end
      end

      private

      def banknotes_params
        params[:banknotes]
      end
    end
  end
end
