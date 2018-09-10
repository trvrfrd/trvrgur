require "rails_helper"

describe "sign up" do
  it "signs up with email, username, and password" do
    visit root_path
    click_on "sign up"
    fill_in "email", with: "fake@example.com"
    fill_in "username", with: "fakefakefake"
    fill_in "password", with: "password123"
    expect { click_button "sign up" }.to change { User.count }.by 1
    expect(page).to have_content "fakefakefake"
  end
end
