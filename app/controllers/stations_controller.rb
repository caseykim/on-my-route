class StationsController < ApplicationController
  def index
    @line = Line.find(params[:line_id])
    order = "lines_stations.station_sequence"
    @stations = @line.stations.includes(:lines_stations).order(order)
    render partial: 'stations_list',
           locals: { stations: @stations },
           layout: false
  end
end
