module ExceptionHandler
  extend ActiveSupport::Concern

   # Define custom error subclasses - rescue catches `StandardErrors`
  class AuthenticationError < StandardError; end
  class BalanceInsufficientError < StandardError; end

  included do
    # Define custom handlers
    rescue_from ActiveRecord::RecordInvalid, with: :four_twenty_two
    rescue_from ExceptionHandler::BalanceInsufficientError, with: :insufficient_balance
    rescue_from ExceptionHandler::AuthenticationError, with: :four_zero_one

  end

  private

  # JSON response with message; Status code 422 - unprocessable entity
  def four_twenty_two(e)
   render json: { message: e.message }, status: :unprocessable_entity
  end
  
  # JSON response with message; Status code 422 - unprocessable entity
  def insufficient_balance
    render json: { message: "Balance is not sufficient to complete this transaction" }, status: :unprocessable_entity
  end


  # JSON response with message; Status code 401 - Unauthorized
  def four_zero_one(e)
    render json: { message: e.message }, status: :unauthorized
  end

end
