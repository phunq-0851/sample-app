class MicropostsController < ApplicationController
  before_action :logged_in_user, only: %i(create destroy)
  before_action :correct_user, only: :destroy

  def create
    @micropost = current_user.micropost.build micropost_params
    if @micropost.save
      flash[:success] = t "controllers.microposts_controller.created"
      redirect_to root_url
    else
      @feed_item = []
      render "static_pages/home"
    end
  end

  def destroy
    if @micropost.destroy
      flash[:success] = I18n.t "controllers.microposts_controller.deleted"
    else
      flash[:danger] = I18n.t "controllers.microposts_controller.not"
    redirect_to request.referrer || root_url
  end

  private

    def micropost_params
      params.require(:micropost).permit :content, :picture
    end

    def correct_user
      @micropost = current_user.microposts.find_by id: prams[:id]
      redirect_to root_url if @micropost.nil?
    end
end
