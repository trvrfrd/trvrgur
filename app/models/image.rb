class Image < ActiveRecord::Base
  attr_accessible :description, :title, :user_id, :album_id, :file

  has_attached_file :file,
    :styles => {
      :small => "100x100#",
      :medium => "600>"
    }

  validates_attachment_presence :file
  validates_attachment_content_type :file, content_type: ["image/jpeg", "image/gif", "image/png"]

  belongs_to :album

  belongs_to :uploader,
             :class_name => "User",
             :foreign_key => :uploader_id
end
