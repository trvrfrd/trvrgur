class CommentsController < ApplicationController
  before_action :require_logged_in, :except => [:show]

  def create
    @comment = Comment.new(comment_params)
    @comment.author_id = current_user.id
    if @comment.save
      redirect_to album_url(@comment.album_id)
    else
      flash[:alerts] ||= []
      flash[:alerts] += @comment.errors.full_messages
      redirect_back(fallback_location: root_url)
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    flash[:notices] ||= []
    flash[:notices] << "comment deleted successfully"
    redirect_to album_url(@comment.album_id)
  end

  def downvote
    @comment = Comment.fetch.find(params[:id])
    if @comment.downvoter_ids.include?(current_user.id)
      @comment.downvoter_ids -= [current_user.id]
      @comment.downvote_count -= 1
    else
      @comment.downvoter_ids += [current_user.id]
      @comment.downvote_count += 1
    end
    @comment.save
    redirect_to album_url(@comment.album_id)
  end

  def edit

  end

  def index
    @comments = Comment.fetch.where("album_id = ?", params[:album_id])
    render :index
  end

  def show
    @comment = Comment.fetch.find(params[:id])
    render :show
  end

  def update

  end

  def upvote
    @comment = Comment.fetch.find(params[:id])
    if @comment.upvoter_ids.include?(current_user.id)
      @comment.upvoter_ids -= [current_user.id]
      @comment.upvote_count -= 1
    else
      @comment.upvoter_ids += [current_user.id]
      @comment.upvote_count += 1
    end
    @comment.save
    redirect_to album_url(@comment.album_id)
  end


  private

  def comment_params
    params.fetch(:comment, {}).permit(:album_id, :author_id, :body, :parent_comment_id)
  end
end
