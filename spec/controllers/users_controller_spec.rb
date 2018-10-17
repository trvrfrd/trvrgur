require "rails_helper"

RSpec.describe UsersController do
  fixtures(:users)
  let(:user) { users(:normal_user) }

  describe "POST #create" do
    it "redirects to home page and logs user in when successful" do
      allow_any_instance_of(User).to receive(:save).and_return(true)
      post :create
      expect(response).to redirect_to root_url
      # this seems weak but I don't want to deal with actually saving users to DB
      expect(session[:session_token]).to eq assigns(:user).session_token
    end

    it "renders :new form when unsuccessful" do
      allow_any_instance_of(User).to receive(:save).and_return(false)
      post :create
      expect(response).to render_template :new
      expect(assigns(:user)).to be_a_new_record
    end

    it "redirects to home page when there is already a user logged in" do
      log_in_as user
      post :create
      expect(response).to redirect_to root_url
      expect(assigns(:user)).to be_nil
    end
  end

  describe "DELETE #destroy" do
    it "calls destroy on logged-in user" do
      log_in_as user
      expect(User).to receive(:find).with(user.id.to_s).and_return(user)
      expect(user).to receive(:destroy)
      delete :destroy, id: user.id
      expect(response).to redirect_to new_user_url
    end

    pending "doesn't destroy user other than logged-in user" do
      log_in_as user
      expect(User).not_to receive(:find).with(users(:other_normal_user).id.to_s)
      delete :destroy, id: users(:other_normal_user).id
      expect(response).to redirect_to root_url
    end

    it "redirects to login page when not logged in" do
      expect(User).not_to receive(:find).with(user.id.to_s)
      delete :destroy, id: user.id
      expect(response).to redirect_to new_session_url
    end
  end

  describe "GET #edit" do
    it "renders :edit form for logged in user" do
      log_in_as user
      get :edit, id: user.id
      expect(response).to be_successful
      expect(response).to render_template :edit
      expect(assigns(:user).id).to eq user.id
    end

    pending "doesn't render :edit form for a user other than logged-in user" do
      log_in_as user
      get :edit, id: users(:other_normal_user).id
      expect(response).to redirect_to root_url
    end

    it "redirects to login page when not logged in" do
      get :edit, id: user.id
      expect(response).to redirect_to new_session_url
    end
  end

  describe "GET #new" do
    it "responds with success and renders template :new with a fresh User" do
      get :new
      expect(response).to be_successful
      expect(response).to render_template :new
      expect(assigns(:user)).to be_new_record
    end

    it "redirects to home page when there is already a user logged in" do
      log_in_as user
      get :new
      expect(response).to redirect_to root_url
      expect(assigns(:user)).to be_nil
    end
  end

  describe "GET #show" do
    it "shows user successfully(?)" do
      get :show, id: user.id
      expect(response).to be_successful
      expect(response).to render_template :show
      expect(assigns(:user).id).to eq user.id
    end
  end

  describe "PATCH #update" do
    it "redirects to User show page when successful" do
      allow_any_instance_of(User).to receive(:update_attributes).and_return true
      log_in_as user
      put :update, id: user.id
      expect(response).to redirect_to user_url(user)
      expect(assigns(:user).id).to eq user.id
    end

    it "renders :edit form when unsuccessful" do
      allow_any_instance_of(User).to receive(:update_attributes).and_return false
      log_in_as user
      put :update, id: user.id
      expect(response).to render_template :edit
      expect(assigns(:user).id).to eq user.id
    end

    pending "doesn't update a user other than logged-in user" do
      log_in_as user
      put :update, id: users(:other_normal_user).id
      expect(response).to redirect_to root_url
    end

    it "redirects to login page when not logged in" do
      put :update, id: user.id
      expect(response).to redirect_to new_session_url
    end
  end
end
