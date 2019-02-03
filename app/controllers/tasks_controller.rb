class TasksController < ApplicationController
  before_action :set_task, only: [:edit, :update, :show]

  def index
    @tasks = Task.all
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    if @task.save
      redirect_to tasks_path
      flash[:notice] = 'TODOを新規作成しました！'
    else
      render action: :new
    end
  end

  def edit
  end

  def update
  end

  def delete
  end

  def show
  end

  private

  def task_params
    params.require(:task).permit(:title, :description)
  end

  def set_task
    @task = Task.find(params[:id])
  end


end
