require "rails_helper"

RSpec.describe CommentsController do
  fixtures(:users, :comments, :albums)
  let(:user) { users(:normal_user) }
  let(:comment) { comments(:normal_comment) }

  describe "POST #create" do
    it "redirects to login page when not logged in" do
      post :create
      expect(response).to redirect_to new_session_url
    end

    it "redirects to album show page when successful" do
      log_in_as user
      allow_any_instance_of(Comment).to receive(:save).and_return(true)

      post :create, params: { comment: { album_id: comment.album.id } }
      expect(response).to redirect_to album_url(comment.album)
    end

    it "redirects back when unsuccessful" do
      log_in_as user
      # have to set some referrer to redirect back to, doesn't matter what it is
      request.env["HTTP_REFERER"] = "fake url"
      allow_any_instance_of(Comment).to receive(:save).and_return(false)

      post :create
      expect(response).to redirect_to "fake url"
    end
  end

  describe "DELETE #destroy" do
    it "redirects to login page when not logged in" do
      delete :destroy, params: { id: comment.id }
      expect(response).to redirect_to new_session_url
    end

    it "redirects to comment's album's show page when successful" do
      log_in_as user
      allow_any_instance_of(Comment).to receive(:destroy).and_return(true)

      delete :destroy, params: { id: comment.id }
      expect(response).to redirect_to album_url(comment.album)
    end

    pending "doesn't destroy comment that doesn't belong to logged-in user"
  end

  describe "POST #downvote" do
    it "redirects to login page when not logged in" do
      post :downvote, params: { id: comment.id }
      expect(response).to redirect_to new_session_url
    end

    it "downvotes comment and renders :show" do
      log_in_as user

      expect { post :downvote, params: { id: comment.id } }.to change{ comment.reload.downvote_count }.by(1)
      expect(response).to redirect_to album_url(comment.album)
    end

    it "undoes downvote if it already exists" do
      log_in_as user

      post :downvote, params: { id: comment.id }
      expect { post :downvote, params: { id: comment.id } }.to change{ comment.reload.downvote_count }.by(-1)
      expect(response).to redirect_to album_url(comment.album)
    end
  end

  pending "GET #edit" # controller method is empty

  pending "PATCH #update" # controller method is empty

  describe "POST #upvote" do
    it "redirects to login page when not logged in" do
      post :upvote, params: { id: comment.id }
      expect(response).to redirect_to new_session_url
    end

    it "upvotes comment and renders :show" do
      log_in_as user

      expect { post :upvote, params: { id: comment.id } }.to change{ comment.reload.upvote_count }.by(1)
      expect(response).to redirect_to album_url(comment.album)
    end

    it "undoes upvote if it already exists" do
      log_in_as user

      post :upvote, params: { id: comment.id }
      expect { post :upvote, params: { id: comment.id } }.to change{ comment.reload.upvote_count }.by(-1)
      expect(response).to redirect_to album_url(comment.album)
    end
  end
end
