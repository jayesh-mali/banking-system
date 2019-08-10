class Transaction < ApplicationRecord
  include Sequencer

  belongs_to :sender_account, class_name: 'User'
  belongs_to :recipient_account, class_name: 'User'

  before_create :set_transaction_id

  validates :transaction_id, uniqueness: true

  def self.create_transaction(params, current_user_id)
    transaction = Transaction.new(mode: params[:mode], amount: params[:amount], created_by_id: current_user_id)
    sender_account = Account.find_by(account_number: params[:sender_account_number])
    recipient_account = Account.find_by(account_number: params[:recipient_account_number])
    transaction.validate_attributes(recipient_account,sender_account,params)
    
    if transaction.errors.blank?
      if params[:mode] != "cash" && sender_account.user_id != current_user_id
        transaction.errors.add(:base, :not_authorize, message: "You are not authorize to complete this transaction")
      else
        ActiveRecord::Base.transaction do
          sender_account.withdrawal(params[:amount]) if params[:mode] != "cash"
          recipient_account.deposite(params[:amount])
          transaction.assign_attributes(sender_account_id: sender_account.id) if sender_account.present?
          transaction.assign_attributes(recipient_account_id: recipient_account.id)
          transaction.save!
        end
      end
    end
    return transaction
  end


  def validate_attributes(recipient_account,sender_account,params)
    self.errors.add(:base, :sender_account_not_found, message: "Unable to find sender account") if (params[:mode] != "cash" && sender_account.nil?)
    self.errors.add(:base, :recipient_account_not_found, message: "Unable to find recipient account") if recipient_account.nil?
  end

  private

  def set_transaction_id
    self.generate_sequence_no("transaction_id")
  end
end
