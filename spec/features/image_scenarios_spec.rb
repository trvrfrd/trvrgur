require "rails_helper"

describe "uploading an image" do
  let(:file_path) { "#{Rails.root}/spec/fixtures/files/image.png" }

  describe "success" do
    before(:each) do
      stub_request(:put, Regexp.new("https://test.s3.test.amazonaws.com/images/files/"))
        .to_return(status: 200)
    end

    it "works when not logged in, without title or description" do
      visit new_image_path
      attach_file "image_file", file_path
      click_on "upload image"
      expect(page).to have_content "image uploaded successfully"
    end
  end
end
