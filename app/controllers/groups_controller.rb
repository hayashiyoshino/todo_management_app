class GroupsController < ApplicationController

  def index
    @group = Group.find_by(group_name: params[:group_name])
    @user = User.find(params[:id])
    if @group == nil
      redirect_to @user
      flash[:notice] = 'そのようなグループは存在しません'
    else
      render template: 'users/show'
    end
  end

  def new
    @group = current_user.groups.new
  end

  def create
    @group = Group.where(group_params).first_or_initialize
    if @group.save
      if GroupUser.where(group_id: @group.id, user_id: current_user.id) == []
        current_user.groups << @group
      end
      redirect_to user_path(current_user)
    else
      render :new
    end
  end

  def show

  end

  private

  def group_params
    params.require(:group).permit(:group_name)
  end

end
