class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      redirect_to @user
      flash[:notice] = "新規登録しました！"
    else
      render :new
    end
  end

  def show
    @user = User.find(params[:id])
    gon.tasks = current_user.tasks.includes(:user).where("deadline < ?", Date.current).map(&:title)
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

end
