class GroupsController < ApplicationController
  def new
    @group = Group.new
  end

  def create
    @group = Group.new(group_params)
    if @group.save
      flash[:success] = 'Group created'
      redirect_to request.referer
    else
      render 'new'
    end
  end

  private

  def group_params
    params.require(:group).permit(:name, :created_at)
  end
end
