# frozen_string_literal: true

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  include DeviseTokenAuth::Concerns::User

  has_many :accounts, dependent: :destroy

  has_many :addresses, dependent: :destroy

  validates :pan_number, presence: true
  validates :pan_number, uniqueness: true

  after_create :create_account

  def create_account
    self.accounts.create(account_type:Account.account_types[:SAVING],created_by_id:self.id,updated_by_id:self.id)
  end

end
