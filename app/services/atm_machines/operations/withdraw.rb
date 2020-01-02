module AtmMachines
  module Operations
    class Withdraw
      def initialize(atm_id)
        @atm = AtmMachine.find(atm_id)
      end

      def perform(amount)
        banknotes = Hash.new(0)
        notes = @atm.notes.sort_by {|k,v| k.to_i}.reverse.to_h
        notes.each do |note, quantity|
          num = amount / note.to_i

          next if quantity == 0 || num == 0
          allowed_quantity = (quantity - num) > 0 ? num : quantity
          amount -= allowed_quantity * note.to_i
          banknotes[note] += allowed_quantity
        end

        if amount !=0
          "Error! We can't withdraw this amount."
        else
          update_notes(notes.map { |n, q| [n, q - banknotes[n] ] }.to_h)
          message = banknotes.map { |n, q| "#{q} notes with #{n}" }
          "Get your money: #{message.join(', ')}."
        end
      end
    end
  end
end
