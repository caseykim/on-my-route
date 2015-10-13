class ConstructionsController < ApplicationController
  def index
    if params[:line_id]
      line = Line.find(params[:line_id])
      @constructions = line.constructions
    elsif params[:station] && params[:station] != ""
      @constructions = Construction.search(params[:station])
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
    construction = Construction.find(params[:id])
    if signed_in? && current_user == construction.user
      @construction = construction
    elsif !signed_in?
      authenticate_user!
    else
      flash[:alert] = 'You have no permission to edit this posting'
      redirect_to constructions_path
    end
  end

  def update
    @construction = Construction.find(params[:id])
    if @construction.update_attributes(construction_params)
      flash[:success] = 'Construction updated successfully.'
      redirect_to constructions_path
    else
      flash[:alert] = @construction.errors.full_messages.join(", ")
      render :edit
    end
  end

  def destroy
    construction = Construction.find(params[:id])
    if signed_in? && current_user == construction.user
      construction.destroy
      flash[:success] = 'Construction deleted successfully.'
      redirect_to constructions_path
    elsif !signed_in?
      authenticate_user!
    else
      flash[:alert] = 'You have no permission to edit this posting'
      redirect_to constructions_path
    end
  end

  private

  def construction_params
    params.require(:construction).permit(:line_id,
      :start_station_id, :end_station_id, :start_date, :end_date,
      :start_time, :end_time, :description)
  end
end
