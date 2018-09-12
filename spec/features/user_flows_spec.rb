require "rails_helper"

describe "sign up" do
  it "signs up with email, username, and password" do
    visit root_path
    click_on "sign up"
    fill_in "email", with: "fake@example.com"
    fill_in "username", with: "fakefakefake"
    fill_in "password", with: "password123"
    expect { click_button "sign up" }.to change { User.count }.by 1
    expect(current_path).to eq root_path
    expect(page).to have_content "fakefakefake"
  end

  it "signs up as a guest (this is probably a bad feature that should be removed)" do
    visit root_path
    click_on "sign up"
    expect { click_on "sign in as a guest" }.to change { User.count }.by 1
    expect(current_path).to eq root_path
    expect(page).to have_content "guest" # this is real weak but so are my CSS selectors
  end
end

describe "sign in" do
  let(:user) do
    # doing this rather than fixtures because of complications around
    # password_digest and session_token creation, handled easiest at model level
    User.create!(username: "whatever", email: "fake@example.com", password: "password123")
  end

  before(:each) do
    visit root_path
    click_on "sign in"
  end

  it "signs in with username" do
    fill_in "username or email", with: user.username
    fill_in "password", with: "password123"
    click_button "sign in"
    expect(current_path).to eq root_path
    expect(page).to have_content user.username
  end

  it "signs in with email" do
    fill_in "username or email", with: user.email
    fill_in "password", with: "password123"
    click_button "sign in"
    expect(current_path).to eq root_path
    expect(page).to have_content user.username
  end

  it "gives an error and does not sign in with incorrect password" do
    fill_in "username or email", with: user.username
    fill_in "password", with: "secret"
    click_button "sign in"
    expect(current_path).to eq new_session_path
    expect(page).to have_content "incorrect username or password"
    expect(page).not_to have_content user.username
  end

  it "signs back out" do
    fill_in "username or email", with: user.username
    fill_in "password", with: "password123"
    click_button "sign in"
    click_on "sign out"
    expect(current_path).to eq new_session_path
    expect(page).not_to have_content user.username
  end
end
