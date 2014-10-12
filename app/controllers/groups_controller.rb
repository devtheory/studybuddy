class GroupsController < ApplicationController
  def index
    @groups = Group.all
  end

  def show
    @group = Group.find(params[:id])
  end

  def edit
    @group = Group.find(params[:id])
  end

  def update
    @group = Group.find(params[:id])

    if @group.update_attributes(group_params)
      flash[:success] = "You successfully updated the group"
      redirect_to @group
    else
      flash[:error] = "Something went wrong. Please try again"
      render :edit
    end

  end

  def new
    @group = Group.new
  end

  def create
    @group = Group.new(group_params)

    if @group.save
      @membership = Membership.where(user_id: current_user.id, group_id: @group.id).first_or_create
      @membership.role = "admin"
      @membership.save
      redirect_to @group, notice: "You successfully created a group"
    else
      flash[:error] = "Something went wrong. Please try again"
      render :new
    end
  end

  def destroy
    @group = Group.find(params[:id])
    @membership = Membership.where(user_id: current_user.id, group_id: @group.id).first

    if @group.destroy
      flash[:notice] = "The group was deleted successfully"
      @membership.destroy
      redirect_to groups_path
    else
      flash[:error] = "There was an error deleting the group. Please try again"
    end
  end

  private

  def group_params
    params.require(:group).permit(:name, :description)
  end

end
