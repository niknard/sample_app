class SessionsController < ApplicationController
  def create
    user=User.find_by_email(params[:session][:email])
    if user && user.authenticate(params[:session][:password])
      # Welcome to site
      sign_in user
      redirect_to user
    else
      # Go away!
      flash.now[:error]='Unknown user!'
      render 'new'
    end
  end
end
