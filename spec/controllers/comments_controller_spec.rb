require "rails_helper"

RSpec.describe CommentsController do
  fixtures(:users, :comments)
  let(:user) { users(:normal_user) }
  let(:comment) { comments(:normal_comment) }

  describe "POST #create" do
    it "redirects to login page when not logged in" do
      xhr :post, :create
      expect(response).to redirect_to new_session_url
    end

    it "renders show page when successful" do
      log_in_as user
      allow_any_instance_of(Comment).to receive(:save).and_return(true)

      xhr :post, :create
      expect(response).to render_template :show
    end

    it "redirects back when unsuccessful" do
      log_in_as user
      # have to set some referrer or test explodes, doesn't matter what it is
      request.env["HTTP_REFERER"] = root_url
      allow_any_instance_of(Comment).to receive(:save).and_return(false)

      xhr :post, :create
      expect(response).to redirect_to :back
    end
  end

  describe "DELETE #destroy" do
    it "redirects to login page when not logged in" do
      delete :destroy, id: comment.id
      expect(response).to redirect_to new_session_url
    end

    it "redirects to comment's album's show page when successful" do
      log_in_as user
      allow_any_instance_of(Comment).to receive(:destroy).and_return(true)

      delete :destroy, id: comment.id
      expect(response).to redirect_to album_url(comment.album)
    end

    pending "doesn't destroy comment that doesn't belong to logged-in user"
  end

  describe "GET #downvote" do
    it "redirects to login page when not logged in" do
      xhr :get, :downvote, id: comment.id
      expect(response).to redirect_to new_session_url
    end

    it "downvotes comment and renders :show" do
      log_in_as user

      expect { xhr :get, :downvote, id: comment.id }.to change{ comment.reload.downvote_count }.by(1)
      expect(response).to render_template :show
    end

    it "undoes downvote if it already exists" do
      log_in_as user

      xhr :get, :downvote, id: comment.id
      expect { xhr :get, :downvote, id: comment.id }.to change{ comment.reload.downvote_count }.by(-1)
      expect(response).to render_template :show
    end
  end

  pending "GET #edit" # controller method is empty

  describe "GET #index" do
    it "redirects to login page when not logged in" do # for some reason?
      xhr :get, :index, album_id: comment.album_id
      expect(response).to redirect_to new_session_url
    end

    it "renders :index" do
      log_in_as user

      xhr :get, :index, album_id: comment.album_id
      expect(response).to render_template :index
    end
  end

  describe "GET #show" do
    it "renders :show" do
      xhr :get, :show, id: comment.id
      expect(response).to render_template :show
    end
  end

  pending "PUT #update" # controller method is empty

  describe "GET #upvote" do
    it "redirects to login page when not logged in" do
      xhr :get, :upvote, id: comment.id
      expect(response).to redirect_to new_session_url
    end

    it "upvotes comment and renders :show" do
      log_in_as user

      expect { xhr :get, :upvote, id: comment.id }.to change{ comment.reload.upvote_count }.by(1)
      expect(response).to render_template :show
    end

    it "undoes upvote if it already exists" do
      log_in_as user

      xhr :get, :upvote, id: comment.id
      expect { xhr :get, :upvote, id: comment.id }.to change{ comment.reload.upvote_count }.by(-1)
      expect(response).to render_template :show
    end
  end
end
