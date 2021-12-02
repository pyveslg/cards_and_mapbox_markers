class PagesController < ApplicationController
  before_action :set_filters, only: [:home]
  def home
    @cities = @activated_filter == "World" ? City.all : City.where(zone: @activated_filter)
    @markers = @cities.geocoded.map do |city|
      {
        lat: city.latitude,
        lng: city.longitude,
        id: "marker_#{city.id}",
        info_window: render_to_string(partial: "info_window", locals: { city: city }, formats: [:html]),
        zone: city.zone,
        encoded_zone: city.zone_encoded
      }
    end
    respond_to do |format|
      format.html
      format.json { render json: { html: render_to_string(partial: "cities", locals: {cities: @cities, filter: @activated_filter }, formats: [:html]), markers: @markers } }
    end
  end

  private

  def set_filters
    @filters = City.all.map{|city| [city.zone, city.zone_encoded]}.uniq.push(["World", "world"])
    @activated_filter = params[:filter] ? params[:filter] : "World"
  end
end
