require "rails_helper"

RSpec.describe AlbumsController do
  fixtures(:users, :albums, :images)
  let(:user) { users(:normal_user) }
  let(:file) { fixture_file_upload("/files/image.png") }
  let(:album_params) { { empty: false } } # curse you strong params

  describe "POST #create" do
    it "redirects to home page when album saved successfully" do
      allow_any_instance_of(Album).to receive(:save).and_return(true)

      post :create, params: { album: album_params }
      expect(response).to redirect_to root_url
    end

    pending "creates associated images"

    it "renders :new form when album not saved successfully" do
      allow_any_instance_of(Album).to receive(:save).and_return(false)

      post :create, params: { album: album_params }
      expect(response).to render_template :new
      expect(assigns(:album)).to be_a_new_record
    end
  end

  describe "DELETE #destroy" do
    let(:album) { user.albums.first }

    it "redirects to login page when not logged in" do
      delete :destroy, params: { id: album.id }
      expect(response).to redirect_to new_session_url
    end

    it "calls destroy on specified album and redirects to home page" do
      log_in_as user
      allow(Album).to receive(:find).with(album.id.to_s).and_return(album)
      expect(album).to receive(:destroy).and_return(true)

      delete :destroy, params: { id: album.id }

      expect(response).to redirect_to root_url
    end

    pending "doesn't destroy album that doesn't belong to logged-in user"
  end

  describe "POST #downvote" do
    let(:album) { user.albums.first }

    it "redirects to login page when not logged in" do
      post :downvote, params: { id: album.id }
      expect(response).to redirect_to new_session_url
    end

    # this is testing too much but whatever the implementation is bad
    it "downvotes album and renders :show" do
      log_in_as user
      expect { post :downvote, params: { id: album.id } }.to change{ album.reload.downvote_count }.by(1)
      expect(response).to render_template :show
    end

    it "undoes downvote if it already exists" do
      log_in_as user
      post :downvote, params: { id: album.id }
      expect { post :downvote, params: { id: album.id } }.to change{ album.reload.downvote_count }.by(-1)
      expect(response).to render_template :show
    end
  end

  describe "GET #edit" do
    let(:album) { user.albums.first }

    it "redirects to login page when not logged in" do
      get :edit, params: { id: album.id }
      expect(response).to redirect_to new_session_url
    end

    it "render :edit form for specified album" do
      log_in_as user
      allow(Album).to receive(:includes).and_return(Album) # deeply bad
      allow(Album).to receive(:find).with(album.id.to_s).and_return(album)

      get :edit, params: { id: album.id }

      expect(response).to be_successful
      expect(response).to render_template :edit
      expect(assigns(:album).id).to eq album.id
    end

    pending "doesn't edit album that doesn't belong to logged-in user"
  end

  describe "POST #favorite" do
    let(:album) { user.albums.first }

    it "redirects to login page when not logged in" do
      post :favorite, params: { id: album.id }
      expect(response).to redirect_to new_session_url
    end

    it "favorites album and renders :show" do
      log_in_as user
      expect_any_instance_of(Album).to receive(:favoriting_user_ids=).with([user.id]) # o lord
      post :favorite, params: { id: album.id }
      expect(response).to render_template :show
    end

    it "undoes favorite if it already exists" do
      log_in_as user
      post :favorite, params: { id: album.id }
      expect_any_instance_of(Album).to receive(:favoriting_user_ids=).with([]) # o lord
      post :favorite, params: { id: album.id }
      expect(response).to render_template :show
    end
  end

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

    it "renders :show with specified album" do
      allow(Album).to receive(:fetch).and_return(Album)
      expect(Album).to receive(:find).with(album.id.to_s).and_return(album)
      get :show, params: { id: album.id }
      expect(response).to be_successful
      expect(response).to render_template :show
      expect(assigns(:album).id).to eq album.id
    end
  end

  describe "PATCH #update" do
    let(:album) { user.albums.first }
    let(:image) { album.images.first }

    it "redirects to login page when not logged in" do
      patch :update, params: { id: album.id, album: album_params }
      expect(response).to redirect_to new_session_url
    end

    it "redirects to home page when album updated successfully" do
      log_in_as user
      allow_any_instance_of(Album).to receive(:update_attributes).and_return(true)

      patch :update, params: { id: album.id, album: album_params }
      expect(response).to redirect_to root_url
    end

    it "renders :edit when album not updated successfully" do
      log_in_as user
      allow_any_instance_of(Album).to receive(:update_attributes).and_return(false)

      patch :update, params: { id: album.id, album: album_params }
      expect(response).to render_template :edit
      expect(assigns(:album).id).to eq album.id
    end

    it "updates associated images" do
      log_in_as user
      image_params = { id: image.id, title: "new title" }

      # here I go, testing all the way to the database, like a chump
      expect do
        patch :update, params: { id: album.id, album: { images_attributes: { "0" => image_params } } }
      end.to change { image.reload.title }.to("new title")
      expect(response).to redirect_to root_url
    end

    pending "optionally destroys associated images"

    pending "doesn't update album that doesn't belong to logged-in user"
  end

  describe "POST #upvote" do
    let(:album) { user.albums.first }

    it "redirects to login page when not logged in" do
      post :upvote, params: { id: album.id }
      expect(response).to redirect_to new_session_url
    end

    # this is testing too much but whatever the implementation is bad
    it "upvotes album and renders :show" do
      log_in_as user
      expect { post :upvote, params: { id: album.id } }.to change{ album.reload.upvote_count }.by(1)
      expect(response).to render_template :show
    end

    it "undoes upvote if it already exists" do
      log_in_as user
      post :upvote, params: { id: album.id }
      expect { post :upvote, params: { id: album.id } }.to change{ album.reload.upvote_count }.by(-1)
      expect(response).to render_template :show
    end
  end
end
