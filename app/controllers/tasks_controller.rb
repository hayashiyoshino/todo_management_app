class TasksController < ApplicationController
  before_action :require_sign_in
  before_action :set_task, only: [:edit, :update, :destroy]

  def index
    @keyword = params[:keyword]
    tasks = current_user.tasks.includes(:user).search(@keyword).sort_tasks(params[:sort]).pickup_tasks(params[:pickup]).pickup_priority_tasks(params[:pickuppriority]).search_by_lavel(params[:lavelname])
      if tasks != nil
        @tasks = tasks.page(params[:page]).per(10)
      else
        @tasks = []
      end
    @keyword = params[:keyword]
    @lavelname = params[:lavelname]
  end

  def new
    @task = current_user.tasks.new
  end

  def create
    @task = current_user.tasks.new(task_params)
    lavel_list = params[:tags]
    @task.save
    if !@task.new_record?
      @task.save_lavels(lavel_list)
      redirect_to tasks_path
      flash[:notice] = 'TODOを新規作成しました！'
    else
      render :new
    end
  end

  def edit
    @lavel_list = @task.lavels.pluck(:lavel_name).join(",")
    gon.lavel_list = @task.lavels.pluck(:lavel_name).join(",")
  end

  def update
    lavel_list = params[:tags]
    if @task.update(task_params)
      if lavel_list.present?
        @task.save_lavels(lavel_list)
        redirect_to tasks_path
        flash[:notice] = 'TODOを編集しました'
      else
        redirect_to tasks_path
        flash[:notice] = 'TODOを編集しました'
      end
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
