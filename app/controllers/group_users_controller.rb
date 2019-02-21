class GroupUsersController < ApplicationController

  def new
  end

  def create
    group_user =  GroupUser.new(group_user_params)
    if group_user.save
      redirect_to user_path(current_user)
      flash[:notice] = 'グループに参加しました！'
    else
      redirect_to user_path(current_user)
      flash[:notice] = '参加に失敗しました'
    end
  end

  private
  def group_user_params
    @group =  params.permit(:group_id).merge(user_id: current_user.id)
  end
end
