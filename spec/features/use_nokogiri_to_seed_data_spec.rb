require 'rails_helper'
require 'open-uri'

feature 'nokogiri creates stations', %(

) do
  scenario do
    line_name = "Orange"
    url = "http://www.mbta.com/schedules_and_maps/subway/lines/?route=#{line_name.upcase}"
    doc = Nokogiri::HTML(open(url,
      "User-Agent" => "Ruby/#{RUBY_VERSION}",
      "From" => "foo@bar.invalid",
      "Referer" => "http://www.ruby-lang.org/"))
    station_names = []
    doc.css('td a').each do |a|
      if a.attributes["title"]
        station_names << a.attributes["title"].value
      end
    end
    station_names.map! { |name| name.sub(/ Station/, '') }

    line = Line.create(name: line_name)
    station_names.each_with_index do |val, idx|
      station = Station.find_or_create_by(name: val)
      LinesStation.create(line: line, station: station, station_sequence: idx)
    end
  end
end
