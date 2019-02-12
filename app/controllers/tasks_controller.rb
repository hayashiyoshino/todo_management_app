class TasksController < ApplicationController
  before_action :set_task, only: [:edit, :update, :destroy]

  def index
    @tasks = Task.all.order("created_at DESC")
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

  def sort_deadline
    @tasks = Task.all.order('deadline ASC')
  end

  private

  def task_params
    params.require(:task).permit(:title, :description, :deadline)
  end

  def set_task
    @task = Task.find(params[:id])
  end


end
