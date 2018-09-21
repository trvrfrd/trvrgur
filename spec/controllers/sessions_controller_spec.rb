require "rails_helper"

RSpec.describe SessionsController do
  fixtures(:users)
  let(:user) { users(:normal_user) }

  describe "POST #create" do
    it "logs in user and redirects to home page when successful" do
      allow(User).to receive(:check_credentials).and_return(user)
      post :create
      expect(response).to redirect_to root_url
      expect(session[:session_token]).to eq user.session_token
    end

    it "redirects to login page without logging user in when unsuccessful" do
      allow(User).to receive(:check_credentials).and_return(nil)
      post :create
      expect(response).to redirect_to new_session_url
      expect(session[:session_token]).to be_nil
    end

    it "redirects to home page when already logged in" do
      log_in_as user
      expect(User).not_to receive(:check_credentials)
      post :create
      expect(response).to redirect_to root_url
    end
  end

  describe "DELETE #destroy" do
    it "logs out logged-in user and redirects to login page" do
      log_in_as user
      delete :destroy
      expect(session[:sesstion_token]).to be_nil
      expect(response).to redirect_to new_session_url
    end

    it "redirects to login page when not logged in" do
      delete :destroy
      expect(session[:sesstion_token]).to be_nil
      expect(response).to redirect_to new_session_url
    end
  end

  describe "GET #new" do
    it "renders :new form" do
      get :new
      expect(response).to be_successful
    end

    it "redirects to home page when already logged in" do
      log_in_as user
      get :new
      expect(response).to redirect_to root_url
    end
  end
end
