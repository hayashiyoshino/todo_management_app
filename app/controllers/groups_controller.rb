class GroupsController < ApplicationController

  def new
    @group = current_user.groups.new
  end

  def create
    @group = current_user.groups.new(group_params)
    if @group.save
      redirect_to user_path(current_user)
      flash[:notice] = 'グループを新規作成しました！'
    else
      render :new
    end
  end

  private

  def grpup_params
    params.require(:group).permit(:group_name)
  end

end
