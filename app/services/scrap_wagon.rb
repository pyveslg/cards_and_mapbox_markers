require 'open-uri'
require 'nokogiri'

class ScrapWagon

  def initialize(city)
    @city = city
    city_slug = city == "Rio de Janeiro" ? "rio" : city.unicode_normalize(:nfkd).encode("ASCII", replace: '').gsub("\s", "-").downcase
    @base_url = "https://www.lewagon.com/"
    @url = "#{@base_url}#{city_slug}"
  end

  def self.get_all_cities
    main_doc = Nokogiri::HTML(URI.open("https://www.lewagon.com/").read)
    main_doc.search('.footer-section .city-name').map{|city| city.text.strip}
  end

  def get_wagon_address
    {place: @city, address: get_address, photo_url: get_photo, url: @url}
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
