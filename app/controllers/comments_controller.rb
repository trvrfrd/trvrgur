class CommentsController < ApplicationController
  before_filter :require_logged_in, :except => [:show]

  def create
    @comment = Comment.new(params[:comment])
    @comment.author_id = current_user.id
    if @comment.save
      render :show
    else
      flash[:alerts] ||= []
      flash[:alerts] += @comment.errors.full_messages
      redirect_to :back
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    flash[:notices] ||= []
    flash[:notices] << "comment deleted successfully"
    redirect_to album_url(@comment.album)
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
    render :show
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
    render :show
  end
end
