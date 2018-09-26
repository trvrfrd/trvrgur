require "rails_helper"

RSpec.describe AlbumsController do
  fixtures(:users, :albums, :images)
  let(:user) { users(:normal_user) }
  let(:file) { fixture_file_upload("/files/image.png") }

  describe "POST #create" do
    it "redirects to home page when album saved successfully" do
      allow_any_instance_of(CreateAlbum).to receive(:create!).and_return(true)

      post :create
      expect(response).to redirect_to root_url
    end

    pending "creates associated images"

    it "renders :new form when album not saved successfully" do
      allow_any_instance_of(CreateAlbum).to receive(:create!).and_raise

      post :create
      expect(response).to render_template :new
      expect(assigns(:album)).to be_a_new_record
    end
  end

  describe "DELETE #destroy" do
    let(:album) { user.albums.first }

    it "redirects to login page when not logged in" do
      delete :destroy, id: album.id
      expect(response).to redirect_to new_session_url
    end

    it "calls destroy on specified album and redirects to home page" do
      log_in_as user
      allow(Album).to receive(:find).with(album.id.to_s).and_return(album)
      expect(album).to receive(:destroy).and_return(true)

      delete :destroy, id: album.id

      expect(response).to redirect_to root_url
    end

    pending "doesn't destroy album that doesn't belong to logged-in user"
  end

  pending "#downvote"

  describe "GET #edit" do
    let(:album) { user.albums.first }

    it "redirects to login page when not logged in" do
      get :edit, id: album.id
      expect(response).to redirect_to new_session_url
    end

    it "render :edit form for specified album" do
      log_in_as user
      allow(Album).to receive(:includes).and_return(Album) # deeply bad
      allow(Album).to receive(:find).with(album.id.to_s).and_return(album)

      get :edit, id: album.id

      expect(response).to be_successful
      expect(response).to render_template :edit
      expect(assigns(:album).id).to eq album.id
    end

    pending "doesn't edit album that doesn't belong to logged-in user"
  end

  pending "#favorite"

  describe "GET #index" do
    it "renders :index" do # this seems not like a high-value test
      get :index
      expect(response).to be_successful
      expect(response).to render_template :index
      expect(assigns(:albums)).not_to be_nil
    end
  end

  describe "GET #new" do
    it "renders :new with a new Album without requiring login" do
      get :new
      expect(response).to be_successful
      expect(response).to render_template :new
      expect(assigns(:album)).to be_a_new_record
    end
  end

  describe "GET #show" do
    let(:album) { albums(:with_one_image) }

    it "renders :show with specified album (AJAX only I guess)" do
      allow(Album).to receive(:fetch).and_return(Album)
      expect(Album).to receive(:find).with(album.id.to_s).and_return(album)
      xhr :get, :show, id: album.id
      expect(response).to be_successful
      expect(response).to render_template :show
      expect(assigns(:album).id).to eq album.id
    end
  end

  describe "PUT #update" do
    let(:album) { user.albums.first }
    let(:image) { album.images.first }

    it "redirects to login page when not logged in" do
      put :update, id: album.id
      expect(response).to redirect_to new_session_url
    end

    it "redirects to home page when album updated successfully" do
      log_in_as user
      # this is some more ugly shit for another ugly controller action
      allow(Album).to receive(:find).with(album.id.to_s).and_return(album)
      allow(album).to receive(:update_attributes).and_return(true)
      allow_any_instance_of(Image).to receive(:valid?).and_return(true)

      put :update, id: album.id, images: {}
      expect(response).to redirect_to root_url
    end

    it "renders :edit when album not updated successfully" do
      log_in_as user
      allow(Album).to receive(:find).with(album.id.to_s).and_return(album)
      allow(album).to receive(:update_attributes).and_return(false)
      allow_any_instance_of(Image).to receive(:valid?).and_return(false)

      put :update, id: album.id, images: {}
      expect(response).to render_template :edit
      expect(assigns(:album).id).to eq album.id
    end

    it "updates associated images" do
      log_in_as user
      # how do things keep getting worse
      allow(Album).to receive(:find).with(album.id.to_s).and_return(album)
      allow(album).to receive(:update_attributes).and_return(true)
      allow(album.images).to receive(:find_by_id).with(image.id).and_return(image)
      allow_any_instance_of(Image).to receive(:valid?).and_return(true)

      image_params = { title: "new title" }
      expect(image).to receive(:update_attributes).with(image_params)

      put :update, id: album.id, images: { image.id => image_params }
      expect(response).to redirect_to root_url
    end

    pending "optionally destroys associated images"

    pending "doesn't update album that doesn't belong to logged-in user"
  end

  pending "#upvote"
end
