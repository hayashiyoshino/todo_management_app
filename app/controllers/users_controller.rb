class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if image = params[:user][:image]
      @user.image.attach(image)
    end
    if @user.save
      log_in @user
      redirect_to @user
      flash[:notice] = "新規登録しました！"
    else
      render :new
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if image = params[:user][:image]
      @user.image.attach(image)
    end
    if @user.update(user_params)
      redirect_to @user
      flash[:notice] = "プロフィールを更新しました！"
    else
      render :edit
    end
  end

  def show
    @user = User.find(params[:id])
    # gon.overtasks = current_user.tasks.includes(:user).where("deadline < ?", Date.current).map(&:title)
    # gon.neartasks = current_user.tasks.includes(:user).where(deadline: Date.current..Date.current+3)
    userparam = params[:username]
    if userparam.present?
      username = User.find_by(name: params[:username])
      @username = params[:username]
      if username != nil
        @tasks = Task.where(user_id: username.id)
      else
        redirect_to @user
        flash[:notice] = "そのようなユーザーは存在しません"
      end
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :image)
  end

end
