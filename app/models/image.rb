class Image < ActiveRecord::Base
  attr_accessible :description, :title, :user_id, :file
  has_attached_file :file, :styles => { :small => "100x100#" }

  validates :file, :attachment_presence => true

  belongs_to :user
end
