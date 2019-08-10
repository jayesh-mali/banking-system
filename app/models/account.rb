class Account < ApplicationRecord
    include Sequencer
    belongs_to :user
    has_many :withdrawal_transactions, class_name: 'Transaction', foreign_key: :sender_account, dependent: :destroy
    has_many :deposited_transactions, class_name: 'Transaction', foreign_key: :recipient_account, dependent: :destroy
    
    validates :account_number, uniqueness: true

    before_create :set_account_number

    enum account_type: {SAVING:"saving",CURRENT:"current"}

    def withdrawal(amount)
        if self.balance >= amount
            self.update!(balance:self.balance-amount)
        else
            self.errors.add(:insufficient_balance, "Insufficient Balance.")
            raise ActiveRecord::RecordInvalid.new(self)
        end
    end

    def deposite(amount)
        self.update!(balance:self.balance+amount)
    end

    def account_status
        status = {}
        status["withdrawal_amount"] = self.withdrawal_transactions.sum(:amount)
        status["deposited_amount"] = self.deposited_transactions.sum(:amount)
        status["balance"] = self.balance
        return status
    end

    private

    def set_account_number
        self.generate_sequence_no("account_number")          
    end
end
