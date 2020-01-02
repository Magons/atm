module AtmMachines
  module Operations
    class Insert
      def initialize(params)
        @atm = AtmMachine.find(params[:id])
        @banknotes = params[:banknotes]
      end

      def perform(notes)
        updated_notes = {}
        current_notes = @atm.notes
        AtmMachine::NOTES.each do |note|
          updated_notes[note] = notes[note].to_i + current_notes[note].to_i
        end
        update_notes(updated_notes)
        @atm
      end
    end
  end
end
