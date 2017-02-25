class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :require_login
  skip_before_action :require_login, only: [:index, :new, :create]
 
  def index
    @users = User.all
  end
 
  def show
  end
 
  def new
    @user = User.new
  end
 
  def edit
    redirect_to root_path if current_user.id != @user.id
  end
 
  def create
    @user = User.new(user_params)

    if @user.save
      login(params[:email], params[:password])
      redirect_to root_path, info: 'User was successfully created.' 
    else
      render :new 
    end
  end

  def update
    if @user.update(user_params)
      redirect_to @user, info: 'User was successfully updated.' 
    else
      render :edit 
    end
  end

  def destroy
    @user.destroy
    redirect_to root_path, info: 'User was successfully destroyed.' 
  end

  private
    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:email, :password, :password_confirmation)
    end
end
