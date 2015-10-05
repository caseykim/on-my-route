class ConstructionsController < ApplicationController
  def index
    @constructions = Construction.all
  end

  def new
    @construction = Construction.new
  end

  def create
    @construction = Construction.new(construction_params)
    if @construction.save
      flash[:success] = 'New construction successfully added.'
      redirect_to constructions_path
    else
      flash[:alert] = @construction.errors.full_messages.join(', ')
      render :new
    end
  end

  private

  def construction_params
    params.require(:construction).permit(:line_id,
      :start_station_id, :end_station_id, :start_date, :end_date,
      :start_time, :end_time, :description)
  end
end
