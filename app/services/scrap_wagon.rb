require 'open-uri'
require 'nokogiri'

class ScrapWagon

  def initialize(attributes = {})
    @city = attributes[:city]
    @zone = attributes[:zone]
    city_slug = @city == "Rio de Janeiro" ? "rio" : @city.unicode_normalize(:nfkd).encode("ASCII", replace: '').gsub("\s", "-").downcase
    @base_url = "https://www.lewagon.com/"
    @url = "#{@base_url}#{city_slug}"
  end

  def self.get_all_cities_and_zones
    main_doc = Nokogiri::HTML(URI.open("https://www.lewagon.com/").read)
    main_doc.search('footer .wrapper:nth-child(3) .footer-section .column').map do |zone|
      world_zone = zone.search('span')[0].text.strip
      zone.search('.city-name').map do |city|
        { zone: world_zone, city: city.text.strip }
      end
    end
  end

  def get_wagon_address
    {zone: @zone, place: @city, address: get_address, photo_url: get_photo, url: @url}
  end

  private

  def get_photo
    main_doc = Nokogiri::HTML(URI.open(@url).read)
    photo_url = main_doc.search('.header-background')[0]["data-srcset"].split(" ").first
  end

  def get_address
    begin
      URI.open("#{@url}/city_map")
    rescue OpenURI::HTTPError
      p "😬 #{@url} failing"
      return nil
    else
      address_doc = Nokogiri::HTML(URI.open("#{@url}/city_map").read)
      address = address_doc.search('address a').text.strip
    end
  end
end
