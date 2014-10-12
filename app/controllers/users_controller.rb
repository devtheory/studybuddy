class UsersController < ApplicationController
# before_filter :authenticate_user!

  def index
    @users = User.all
  end
  
  # def update
  #   if current_user.update_attributes(user_params)
  #     flash[:notice] = "User information updated"
  #     redirect_to edit_user_registration_path(current_user)
  #   else
  #     render "devise/registrations/edit"
  #   end
  # end

  # def edit
  #   @user = User.find(params[id])
  # end

  def update
    @user = User.find(params[:id])

    if @user.update_attributes(user_params)
      flash[:success] = "Your profile was updated successfully"
      redirect_to current_user
    else
      flash[:error] = "Something went wrong. Please try again"
    end

  end

  def show
    @user = User.find(params[:id])
    # @posts = @user.posts.visible_to(current_user)
    respond_to do |f|
      f.html
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :avatar, :email, :bio)
  end
end
