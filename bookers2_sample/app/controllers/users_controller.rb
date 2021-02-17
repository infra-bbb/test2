class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_params_user, except: [:index]
  before_action :define_new_book, only: [:index, :show]

  def index
    @users = User.all
  end

  def show
  end

  def edit
    if @user != current_user
      redirect_to user_path(current_user)
    end
  end

  def update
    if @user.update(user_params)
      flash[:notice] = 'User was successfully updated.'
      redirect_to user_path(@user)
    else
      render :edit
    end
  end
  
  private

  def set_params_user
    @user = User.find(params[:id])
  end

  def define_new_book
    @book = Book.new
  end

  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end

end
