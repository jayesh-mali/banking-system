class RegistrationsController < DeviseTokenAuth::RegistrationsController
    
    private

    def sign_up_params
        params.permit(:name, :pan_number, :email, :password, :password_confirmation)
    end

end
