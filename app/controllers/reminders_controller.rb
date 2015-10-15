class RemindersController < ApplicationController
  before_action :authenticate_user!

  def create
    @user = User.find(params[:user_id])
    @user.update_attributes(user_params)
    @reminder = @user.reminders.new(reminder_params)

    if @reminder.save
      flash[:success] = "Reminder set up successfully."
      redirect_to user_path(@user)
    else
      flash[:alert] = @user.errors.full_messages.join(", ")
      flash[:alert] += "\n" + @reminder.errors.full_messages.join(", ")
      redirect_to :back
    end
  end

  def destroy
    @reminder = Reminder.find(params[:id])
    if current_user == @reminder.user
      @reminder.destroy
      flash[:success] = "You will no longer get a reminder for #{@reminder.line.name}"
      redirect_to user_path(@reminder.user)
    else
      flash[:alert] = 'You have no permission to delete this reminder'
      redirect_to :back
    end
  end

  protected

  def reminder_params
    params.require(:reminder).permit(:line_id)
  end

  def user_params
    params.require(:user).permit(:name, :phone_number)
  end
end
