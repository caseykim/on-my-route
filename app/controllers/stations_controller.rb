class StationsController < ApplicationController
  def index
    @line = Line.find(params[:line_id])
    @stations = @line.stations
    render partial: 'stations_list', locals: { stations: @stations }, layout: false
  end
end
