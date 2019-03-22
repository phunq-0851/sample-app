class UsersController < ApplicationController

  def index
    render template: "static_pages/home"
  end

  def show
    @user = User.find_by id: params[:id]
    if @user.blank?
      flash[:danger] = I18n.t "controllers.users_controller.none"
      redirect_to :root
    end
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      flash[:success] = I18n.t "controllers.users_controller.abc"
      redirect_to @user
    else
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit :name,:email,:password,:password_confirmation
  end
end
