class UsersController < ApplicationController
before_action :signed_in_user, only: [:edit, :update, :index]
before_action :correct_user, only: [:edit, :update]
before_action :admin_user, only: :destroy
before_action :admin_delete_himself, only: :destroy
before_action :resign_user, only: [:create, :new]

  def index
    @users = User.paginate(page: params[:page] )   
  end

  def show
    @user=User.find(params[:id])
    @microposts = @user.microposts.paginate(page: params[:page])
  end

  def new
    @user=User.new
  end
  
  def edit
  end
  
  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted."
    redirect_to users_url
  end
  
  def update
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end
      
  def create
    @user = User.new(user_params)   
    if @user.save
      sign_in @user
      flash[:success] = "Welcome to the Sample App, #{@user.name}!"
      redirect_to @user
    else
      render 'new'
    end
  end
  
  private
  
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
  
  def resign_user
    redirect_to root_url if signed_in?
  end
  
  def signed_in_user
    unless signed_in?
      store_location
      redirect_to signin_url, notice: "Please sign in."
    end
  end
  
  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_url) unless current_user?(@user)
  end
  
  def admin_user
    redirect_to root_url unless current_user.admin?
  end
  
  def admin_delete_himself
    redirect_to root_url if current_user.admin? && (current_user.id == params[:id])
  end
      
end
