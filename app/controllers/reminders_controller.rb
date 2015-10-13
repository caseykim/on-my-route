class RemindersController < ApplicationController
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

  protected

  def reminder_params
    params.require(:reminder).permit(:line_id)
  end

  def user_params
    params.require(:user).permit(:name, :phone_number)
  end
end
