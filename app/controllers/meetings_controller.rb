class MeetingsController < ApplicationController
  def new
    @group = Group.find(params[:group_id])
    @meeting = Meeting.new
  end

  def create
    @group = Group.find(params[:group_id])
    @meeting = @group.meetings.new(meeting_params)

    if @meeting.save
      redirect_to @group, notice: "You successfully created a meeting"
    else
      flash[:error] = "Your meeting was not created. Please try again"
      render :new
    end

  end

  def index
    @group = Group.find(params[:group_id])
    @meetings = @group.meetings
  end

  def show
    @group = Group.find(params[:group_id])
    @meeting = Meeting.find(params[:id])
  end

  def destroy
    @group = Group.find(params[:group_id])
    @meeting = Meeting.find(params[:meeting_id])

    if @meeting.destroy
      redirect_to @group, notice: "Your meeting was destroyed"
    else
      flash[:error] = "Something went wrong. Please try again"
      render :show
    end
  end

  def edit
    @meeting = Meeting.find(params[:id])
  end

  def update
    @meeting = Meeting.find(params[:id])

    if @meeting.update_attributes(meeting_params)
      redirect_to @group, notice: "Your meeting was updated"
    else
      flash[:error] = "Something went wrong. Please try again"
      render :edit
    end
  end

  private

  def meeting_params
    params.require(:meeting).permit(:name, :public, :location, :time)
  end
end
