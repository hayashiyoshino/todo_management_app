class TasksController < ApplicationController
  before_action :require_sign_in
  before_action :set_task, only: [:edit, :update, :destroy]

  def index
    @keyword = params[:keyword]
    @tasks = current_user.tasks.search(@keyword).sort_tasks(params[:sort]).pickup_tasks(params[:pickup]).pickup_priority_tasks(params[:pickuppriority]).page(params[:page]).per(10)
  end

  def new
    @task = current_user.tasks.new
  end

  def create
    @task = current_user.tasks.new(task_params)
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
    params.require(:task).permit(:title, :description, :deadline, :status, :priority)
  end

  def set_task
    @task = Task.find(params[:id])
  end

  def require_sign_in
    redirect_to login_path unless current_user
  end


end
