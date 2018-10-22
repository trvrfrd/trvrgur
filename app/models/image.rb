class Image < ActiveRecord::Base
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

  before_create :associate_with_album_creator


  private

  def associate_with_album_creator
    self.uploader_id = album && album.creator_id
  end
end
