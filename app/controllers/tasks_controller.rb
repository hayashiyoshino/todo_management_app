class TasksController < ApplicationController
  berore_action :set_task, only: [:create, :edit, :update, :show]

  def index
    @tasks = Task.all
  end

  def new
  end

  def create

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

  def set_task
    @task = Task.find(params[:id])
  end


end
