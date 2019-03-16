class Admin::UsersController < ApplicationController
  before_action :require_admin_user
  before_action :set_user, only: [:edit, :update, :destroy, :show, :user_tasks]

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
  end

  def update
    if @user.update(user_params)
      redirect_to(admin_users_path)
    else
      render :edit
    end
  end

  def destroy
    if @user.destroy
      redirect_to(admin_users_path)
      flash[:notice] = 'ユーザーを削除しました'
    else
      render :index
      flash[:notice] = 'ユーザー削除に失敗しました'
    end
  end

  def show
  end

  def user_tasks
    @tasks = @user.tasks.page(params[:page]).per(10)
  end

  private
  
  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :admin)
  end

  def require_admin_user
    redirect_to(root_path) unless current_user.admin?
  end
end
