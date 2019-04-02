class UsersController < ApplicationController
  before_action :logged_in_user, :find_user, except: %i(show create new)
  before_action :correct_user, only: [:edit, :update]
  before_action :admin_user, only: :destroy

  def index
    @users = User.all.page(params[:page]).per(Settings.five)
  end

  def show
    @microposts = @user.microposts.page(params[:page]).per Settings.five
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      log_in @user
      flash[:success] = t "controllers.users_controller.abc"
      redirect_to @user
     UserMailer.account_activation(@user).deliver_now
     flash[:info] = I18n.t "controllers.users_controller.check"
     redirect_to root_url
    else
      render :new
    end
  end

  def edit; end

  def update
    if @user.update user_params
      flash[:success]= I18n.t "controllers.users_controller.update"
      redirect_to @user
    else
      render :edit
    end
  end

  def destroy
    if @user.destroy
      flash[:success] = I18n.t "controllers.users_controller.delete"
    else
      flash[:error] = I18n.t "controllers.users_controller.error"
    end
    redirect_to users_url
  end

  private

  def user_params
    params.require(:user).permit :name,:email,:password,:password_confirmation
  end

  def logged_in_user
    return if logged_in?
    store_location
    flash[:danger] = I18n.t "controllers.users_controller.log_in"
    redirect_to login_url
  end

  def correct_user
    @user = User.find_by id: params[:id]
    redirect_to(root_url) unless current_user?(@user)
  end

  def admin_user
    redirect_to(root_url) unless current_user.admin?
  end

  def find_user
    @user = User.find_by id: params[:id]
    return if @user
    flash[:danger] = t "controllers.users_controller.none"
    redirect_to root_path
  end
end
