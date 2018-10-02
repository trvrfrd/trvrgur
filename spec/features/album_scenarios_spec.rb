require "rails_helper"

# TODO: actually test the images get on the page somehow
describe "creating an album", js: true do
  before(:each) { visit new_album_path }
  let(:file_path) { "#{Rails.root}/spec/fixtures/files/image.png" }

  describe "success" do
    before(:each) do
      stub_request(:put, Regexp.new("https://test.s3.amazonaws.com/images/files/"))
        .to_return(status: 200)
    end

    describe "when not logged in" do
      it "creates an album without title or description, with one image" do
        attach_file "image_file", file_path
        click_on "create album"
        expect(page).to have_content "album created successfully"
        find('a.album-link:last-child').click # lol this is dumb who am i
        expect(page).to have_content "created by: anonymous"
      end

      it "creates an album without title or description, with multiples images" do
        attach_file "image_file", file_path
        click_on "add another image"
        attach_file "images[1][file]", file_path # what have i done
        click_on "add another image"
        attach_file "images[2][file]", file_path # oh no
        click_on "create album"
        expect(page).to have_content "album created successfully"
        find('a.album-link:last-child').click
        expect(page).to have_content "created by: anonymous"
      end

      it "creates an album with title and description, with one image" do
        fill_in "album_title", with: "my good album"
        fill_in "album_description", with: "very good and nice"
        attach_file "image_file", file_path
        click_on "create album"
        expect(page).to have_content "album created successfully"
        find('a.album-link:last-child').click
        expect(page).to have_content "created by: anonymous"
        expect(page).to have_content "my good album"
        expect(page).to have_content "very good and nice"
      end
    end

    describe "when logged in" do
      fixtures(:users)
      let(:user) { users(:normal_user) }
      before(:each) do
        visit new_session_path
        fill_in "username or email", with: user.username
        fill_in "password", with: "password123"
        click_button "sign in"
        visit new_album_path
      end

      it "creates an album without title or description, with one image" do
        attach_file "image_file", file_path
        click_on "create album"
        expect(page).to have_content "album created successfully"
        find('a.album-link:last-child').click
        expect(page).to have_content "created by: #{user.username}"
      end

      it "creates an album without title or description, with multiples images" do
        attach_file "image_file", file_path
        click_on "add another image"
        attach_file "images[1][file]", file_path # what have i done
        click_on "add another image"
        attach_file "images[2][file]", file_path # oh no
        click_on "create album"
        expect(page).to have_content "album created successfully"
        find('a.album-link:last-child').click
        expect(page).to have_content "created by: #{user.username}"
      end

      it "creates an album with title and description, with one image" do
        fill_in "album_title", with: "my good album"
        fill_in "album_description", with: "very good and nice"
        attach_file "image_file", file_path
        click_on "create album"
        expect(page).to have_content "album created successfully"
        find('a.album-link:last-child').click
        expect(page).to have_content "created by: #{user.username}"
        expect(page).to have_content "my good album"
        expect(page).to have_content "very good and nice"
      end
    end
  end

  describe "failure" do
    it "shows an error when creating an album without an image" do
      click_on "create album"
      expect(page).to have_content "Images can't be blank"
    end
  end
end

describe "upvoting and downvoting", js: true do
  before(:each) do
    visit root_path
    find(".album-link:first-of-type").click
  end

  describe "when logged in" do
    fixtures(:users)
    let(:user) { users(:normal_user) }

    before(:each) do
      visit new_session_path
      fill_in "username or email", with: user.username
      fill_in "password", with: "password123"
      click_button "sign in"
      visit root_path
      find(".album-link:first-of-type").click
    end

    it "increments point count by clicking upvote, cancels by clicking again" do
      expect(page).to have_content "points: 0"
      find(".upvote").click
      expect(page).to have_content "points: 1"
      find(".upvote").click
      expect(page).to have_content "points: 0"
    end

    it "decrements point count by clicking downvote, cancels by clicking again" do
      expect(page).to have_content "points: 0"
      find(".downvote").click
      expect(page).to have_content "points: -1"
      find(".downvote").click
      expect(page).to have_content "points: 0"
    end

    pending "can't upvote and downvote the same album"
  end

  it "does nothing when logged out" do
    expect(page).to have_content "points: 0"
    find(".upvote").click
    expect(page).not_to have_content "points: 1"
    find(".downvote").click
    expect(page).not_to have_content "points: -1"
  end
end

describe "commenting" do
end
