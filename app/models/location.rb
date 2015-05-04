class Location < ActiveRecord::Base
  searchkick locations: ["location"]
  belongs_to :post

  def search_data
    attributes.merge location: [latitude, longitude]
  end 
  geocoded_by :ip_address
  after_validation :geocode, if: :ip_address_changed?
  reverse_geocoded_by :latitude, :longitude # do |obj,results|
    # if geo = results.first
    #   obj.city = geo.city
    #   obj.save
    # end 
    # # debugger
  # end 
  after_validation :reverse_geocode
end
