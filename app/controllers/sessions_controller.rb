class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email])
    if user
      log_in user
      redirect_to user_path(current_user)
    else
      flash[:notice] = 'invalid email/password combination'
      render :new
    end
  end

  def destroy
  end
end
