cities = ScrapWagon.get_all_cities
cities.each do |city|
  city = City.find_or_create_by!(ScrapWagon.new(city).get_wagon_address)
  if City.not_geocoded.include?(city)
    city.update!(
      latitude: Geocoder.search(city.place).first.coordinates[0],
      longitude: Geocoder.search(city.place).first.coordinates[1]
    )
  end
end
