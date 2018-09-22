require "rails_helper"

describe "creating an album" do
  let(:file_path) { "#{Rails.root}/spec/fixtures/files/image.png" }

  describe "success" do
    before(:each) do
      stub_request(:put, Regexp.new("https://test.s3.amazonaws.com/images/files/"))
        .to_return(status: 200)
    end

    it "works when not logged in, without title or description" do
      visit new_album_path
      attach_file "image_file", file_path
      click_on "create album"
      expect(page).to have_content "album created successfully"
    end
  end
end
