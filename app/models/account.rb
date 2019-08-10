class Account < ApplicationRecord
    include Sequencer
    belongs_to :user
    before_create :set_account_number

    enum account_type: {SAVING:"saving",CURRENT:"current"}

    # private

    def set_account_number
        self.generate_sequence_no("account_number")          
    end
end
