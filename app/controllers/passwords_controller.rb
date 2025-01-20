class PasswordsController < ApplicationController
  before_action :set_user_by_token, only: %i[ edit update ]

  def new
  end

  def create
    if user = User.find_by(email: params[:email])
      PasswordsMailer.reset(user).deliver_later
    end

    redirect_to new_session_path, notice: "Password reset instructions sent (if user with that email address exists)."
  end

  def edit
  end

  def update
    if @user.update(params.permit(:password, :password_confirmation))
      redirect_to new_session_path, notice: "Password has been reset."
    else
      redirect_to edit_password_path(params[:token]), alert: "Passwords did not match."
    end
  end

  private
    def set_user_by_token
      @user = User.find_by_password_reset_token!(params[:token])
    rescue ActiveSupport::MessageVerifier::InvalidSignature
      redirect_to new_password_path, alert: "Password reset link is invalid or has expired."
    end
end
# new_session  GET  /session/new(.:format)   sessions#new
# edit_session GET  /session/edit(.:format)  essions#edit
# session      GET  /session(.:format)       sessions#show
#              PATH /session(.:format)       sessions#update PUT  /session(.:format)                                        sessions#update
#              DELETE session(.:format)      sessions#destroy
#              POST  session(.:format)       sessions#create
