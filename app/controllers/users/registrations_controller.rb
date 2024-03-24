# app/controllers/users/registrations_controller.rb


class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params, only: [:create]

  protected

  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:role])
  end

  def sign_up_params
    params.require(:user).permit(:email, :password, :password_confirmation, :role)
  end
end
