class CreateCities < ActiveRecord::Migration[6.1]
  def change
    create_table :cities do |t|
      t.string :address
      t.string :zone
      t.float :latitude
      t.float :longitude
      t.string :photo_url
      t.string :place
      t.string :url

      t.timestamps
    end
  end
end
