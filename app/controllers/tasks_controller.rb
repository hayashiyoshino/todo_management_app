class TasksController < ApplicationController
  before_action :require_sign_in
  before_action :set_task, only: [:edit, :update, :destroy, :download]

  def index
    @keyword = params[:keyword]
    tasks = current_user.tasks.includes(:user).search(@keyword).sort_tasks(params[:sort]).pickup_tasks(params[:pickup]).pickup_priority_tasks(params[:pickuppriority]).search_by_lavel(params[:lavelname]).rank(:row_order)
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
    if file = params[:task][:file]
      @task.file.attach(file)
    end
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
    if file = params[:task][:file]
      @task.file.attach(file)
    end
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

  def download
    data = @task.file.download
    send_data(data, type: 'image/png', filename: 'download.jpg')
  end

  def calendar
    @tasks = Task.all
  end

  def sort
    @task = Task.find(params[:task_id])
    @task.update(task_params)
  end

  def chart
    tasks = current_user.tasks.includes(:lavels)
    @lavels = []
    tasks.each do |task|
      task.lavels.each do |lavel|
      @lavels << lavel
      end
    end
    @data =  @lavels.group_by{ |lavel| lavel }.values.map{ |ar| ar.size }
    lavel_ids = @lavels.group_by{|lavel|lavel}.keys.map{|i|i.id}
    @lavels = lavel_ids.map{ |id| Lavel.find(id).lavel_name }
    gon.lavels = @lavels
    gon.data = @data
  end

  private

  def task_params
    params.require(:task).permit(:title, :description, :deadline, :status, :priority, :file, :row_order_position, :task_id)
  end

  def set_task
    @task = Task.find(params[:id])
  end

  def require_sign_in
    redirect_to login_path unless current_user
  end


end
