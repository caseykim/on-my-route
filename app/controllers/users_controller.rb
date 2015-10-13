class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = User.find(params[:id])
    @reminders = Reminder.where(user: @user)
    if @user == current_user
      @reminder = @user.reminders.new
    else
      flash[:alert] = "Access Denied"
      redirect_to constructions_path
    end
  end
end
