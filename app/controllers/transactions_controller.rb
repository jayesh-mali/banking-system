class TransactionsController < ApplicationController

    def create
        transaction = Transaction.create_transaction(create_params,current_user.id)
        if transaction.errors.blank?
            render :json => {message: "Transaction is completed"}, status: :created
        else
            render :json => {errors: transaction.errors.messages}, status: :unprocessable_entity
        end
    end

    private

    def create_params
        params.permit(:mode,:amount,:sender_account_number,:recipient_account_number)
    end
    
end
