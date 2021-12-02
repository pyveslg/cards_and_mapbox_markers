class City < ApplicationRecord
  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?

  def zone_encoded
    zone.gsub("\s", "-").downcase
  end
end
