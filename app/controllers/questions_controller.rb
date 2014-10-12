class QuestionsController < ApplicationController
  def new
    @question = Question.new
  end

  def create
    # @group = Group.find(params[:group_id])
    @meeting = Meeting.find(params[:meeting_id])
    @question = @meeting.questions.new(question_params)

    if @question.save
      redirect_to @meeting, notice: "Your question was created"
    else
      flash[:error] = "Something went wrong. Please try again"
      render :new
    end
  end

  def show
    @question = Question.find(params[:id])
  end

  def index
    @meeting = Meeting.find(params[:meeting_id])
    @questions = @meeting.questions
  end

  def edit
    @question = Question.find(params[:id])
  end

  def update
    @meeting = Meeting.find(params[:meeting_id])
    @question = Question.find(params[:id])

    if @question.update_attributes(question_params)
      redirect_to @meeting, notice: ç
    else
      flash[:error] = "Something went wrong. Please try again"
      render :edit
    end
  end

  def destroy
    @meeting = Meeting.find(params[:meeting_id])
    @question = Question.find(params[:id])

    if @question.destroy
      redirect_to @meeting, notice: "Your question was deleted successfully"
    else
      flash[:error] = "Something went wrong. Please try again"
      render :show
    end
  end

  private

  def question_params
    params.require(:question).permit(:name)
  end
end
