class Post < ActiveRecord::Base
  belongs_to :user
  validates :text, presence: true
  has_attached_file :image, :styles => { :medium => "600x00>" }
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/
end
