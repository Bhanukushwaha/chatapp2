# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  def new
  end

  # POST /resource/sign_in
  def create
    user =  User.where(email:  params[:user][:email]).first
    if user
      if user.valid_password?(params[:user][:password])
        @valid = true
        sign_in(user)
      else
        @error = {message: "Your entered incorrect password?", email: true}
      end
    else
      @error = {message: "User Not Found", email: false}
      respond_to do |format|
        format.js             
      end
    end
  end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
