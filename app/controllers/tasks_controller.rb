class TasksController < ApplicationController
  berore_action :set_task, only: [:edit, :update, :show]

  def index
    @tasks = Task.all
  end

  def new
  end

  def create
    Task.create(task_params)
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
