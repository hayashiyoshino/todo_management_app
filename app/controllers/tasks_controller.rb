class TasksController < ApplicationController
  before_action :require_sign_in
  before_action :set_task, only: [:edit, :update, :destroy]

  def index
<<<<<<< HEAD
    @tasks = current_user.tasks.includes(:user).order("created_at DESC").search(params[:keyword]).sort_priority(params[:sortpriority]).page(params[:page]).per(10)
=======
    @tasks = Task.search(params[:keyword]).sort_tasks(params[:sort]).page(params[:page]).per(10)
    @keyword = params[:keyword]
>>>>>>> 13940b7fbbfdec94971ea6c95c7792eb68ebb281
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    @task.save
    if !@task.new_record?
      redirect_to tasks_path
      flash[:notice] = 'TODOを新規作成しました！'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @task.update(task_params)
      redirect_to tasks_path
      flash[:notice] = 'TODOを編集しました'
    else
      render :edit
    end
  end

  def destroy
    if @task.destroy
      redirect_to tasks_path
      flash[:notice] = 'TODOを削除しました'
    else
      render :index
      flash[:notice] = '削除に失敗しました'
    end
  end

  def show
  end

  private

  def task_params
    params.require(:task).permit(:title, :description, :deadline, :status, :priority).merge(user_id: current_user.id)
  end

  def set_task
    @task = Task.find(params[:id])
  end

  def require_sign_in
    redirect_to login_path unless current_user
  end


end
