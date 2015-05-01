class Post < ActiveRecord::Base
  searchkick
  belongs_to :user
  belongs_to :circle
  has_one :location
  validates :text, presence: true
  has_attached_file :image, :styles => { :medium => "600x600>" }
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/
end
