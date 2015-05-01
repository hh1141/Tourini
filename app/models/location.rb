class Location < ActiveRecord::Base
  belongs_to :post
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
