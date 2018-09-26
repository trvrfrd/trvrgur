require "rails_helper"
require "paperclip"

RSpec.describe CreateAlbum do
  let(:file_path) { "#{Rails.root}/spec/fixtures/files/image.png" }
  let(:file) { File.new(file_path) }

  it "builds an Album given a title and description" do
    create = CreateAlbum.new(title: "My Album", description: "Some pics of mine!")

    expect(create.album.title).to eq "My Album"
    expect(create.album.description).to eq "Some pics of mine!"
  end

  it "can set creator_id on built Album" do
    create = CreateAlbum.new(creator_id: 1)
    expect(create.album.creator_id).to eq 1
  end

  it "builds Images given an array of image params" do
    image_params = [{ title: "Pic 1", description: "my first pic", file: file }]
    create = CreateAlbum.new(image_params: image_params)
    image = create.images.first

    expect(image.title).to eq "Pic 1"
    expect(image.description).to eq "my first pic"
    expect(image.file).to be_an_instance_of Paperclip::Attachment
  end

  it "sets uploader_id on built images if passed a creator_id" do
    create = CreateAlbum.new(creator_id: 2, image_params: [{ file: file }])
    expect(create.images.map(&:uploader_id)).to eq [create.creator_id]
  end

  it "is invalid without params for at least one image" do
    create = CreateAlbum.new
    expect(create).not_to be_valid
  end

  it "is invalid with image params that have no file" do
    create = CreateAlbum.new(image_params: [])
    expect(create).not_to be_valid
  end

  it "is valid with an image that includes a file" do
    create = CreateAlbum.new(image_params: [{ file: file }])
    expect(create).to be_valid
  end

  it "raises an error if invalid while calling #create!" do
    create = CreateAlbum.new
    expect(create).to receive(:valid?).and_return(false)
    expect { create.create! }.to raise_exception ArgumentError
  end

  it "saves album and associated images to DB if valid" do
    create = CreateAlbum.new(image_params: [{ file: file }])

    expect_any_instance_of(Paperclip::Attachment).to receive(:save).and_return(true)
    expect { create.create! }.to change { Album.count }.by(1).and change { Image.count }.by(1)
    expect(Album.last.id).to eq(create.album.id)
    expect(Image.last.album_id).to eq(create.album.id)
  end
end
