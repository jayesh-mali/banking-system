class AccountsController < ApplicationController
  before_action :set_account, only: [:show, :list_transactions, :status]

  def index
    @accounts = Account.where(user_id: current_user.id)
    render json: @accounts, status: :ok
  end

  def show
    authorize @account
    if @account.present?
      render json: @account, status: :ok
    else
      render json: { "message": "Unable to find account" }, status: :not_found
    end
  end

  def list_transactions
    authorize @account
    render json: @account.withdrawal_transactions + @account.deposited_transactions
  end

  def status
    authorize @account
    render json: @account.account_status, status: :ok
  end

  private

  def set_account
    @account = Account.find_by_id(params[:id])
  end
end
