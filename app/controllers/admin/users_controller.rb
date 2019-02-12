class Admin::UsersController < ApplicationController
  before_action :admin_user

  def index
    @users = User.all.order("created_at DESC").includes(:tasks)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to(admin_users_path)
    else
      render :new
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])

    if @user.update(user_params)
      redirect_to(admin_users_path)
    else
      render :edit
    end
  end

  def destroy
    @user = User.find(params[:id])
    if @user.destroy
      redirect_to(admin_users_path)
      flash[:notice] = 'ユーザーを削除しました'
    else
      render :index
      flash[:notice] = 'ユーザー削除に失敗しました'
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def user_tasks
    @user = User.find(params[:id])
    @tasks = @user.tasks.page(params[:page]).per(10)
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :admin)
  end

  def admin_user
    redirect_to(root_path) unless current_user.admin?
  end
end
