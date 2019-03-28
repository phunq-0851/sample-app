class PasswordResetsController < ApplicationController
  def new; end

  def create
    @user = User.find_by email: params[:password_reset][:email].downcase
    if @user
      @user.create_reset_digest
      @user.send_password_reset_email
      flash[:info] = t "controllers.password_resets.email_reset"
      redirect_to root_url
    else
      flash.now[:danger] = t "controllers.password_resets.not_found"
      render :new
    end
  end

  def edit; end
end
