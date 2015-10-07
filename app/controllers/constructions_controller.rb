class ConstructionsController < ApplicationController
  def index
    if params[:search]
      @constructions = Construction.search(params[:search])
    else
      @constructions = Construction.all
    end
  end

  def new
    if signed_in?
      @construction = Construction.new
    else
      authenticate_user!
    end
  end

  def create
    @construction = current_user.constructions.new(construction_params)
    if @construction.save
      flash[:success] = 'New construction added successfully.'
      redirect_to constructions_path
    else
      flash[:alert] = @construction.errors.full_messages.join(', ')
      render :new
    end
  end

  def edit
  end

  private

  def construction_params
    params.require(:construction).permit(:line_id,
      :start_station_id, :end_station_id, :start_date, :end_date,
      :start_time, :end_time, :description)
  end
end
