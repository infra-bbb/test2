class RelationshipsController < ApplicationController
  before_action :set_params_user
  before_action :set_new_book, only: [:following, :follower]

  def create
    current_user.follow(@user)
    redirect_to request.referer
  end
  
  def destroy
    current_user.unfollow(@user)
    redirect_to request.referer
  end

  def following
    @users = @user.followings
    @page_name = 'Follow'
    render :index
  end
  
  def follower
    @users = @user.followers
    @page_name = 'Follower'
    render :index
  end

  private

  def set_params_user
    @user = User.find(params[:user_id])
  end

  def set_new_book
    @book = Book.new
  end

end
