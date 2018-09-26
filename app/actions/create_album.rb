class CreateAlbum
  attr_accessor :title, :description, :image_params, :creator_id
  attr_reader :album, :images

  def initialize(title: nil, description: nil, creator_id: nil, image_params: [])
    @title = title
    @description = description
    @image_params = image_params
    @creator_id = creator_id
    build
  end

  def build
    @album = Album.new(title: title, description: description, creator_id: creator_id)
    album.images = build_images
    self
  end

  def build_images
    @images = image_params.map { |params| Image.new(params.merge(uploader_id: creator_id)) }
  end

  def valid?
    album.valid? && images.all?(&:valid?)
  end

  def create!
    raise ArgumentError unless valid?
    album.save!
  end
end
