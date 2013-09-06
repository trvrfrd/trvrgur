class CommentsController < ApplicationController
  before_filter :require_logged_in, :except => [:show]

  def create
    @comment = Comment.new(params[:comment])
    @comment.author_id = current_user.id
    if @comment.save
      flash[:notices] ||= []
      flash[:notices] << "comment posted successfully"  
      redirect_to album_url(@comment.album)
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
    @comment = Comment.find(params[:id])
    @comment.downvotes += 1
    @comment.save
    flash[:notices] ||= []
    flash[:notices] << "comment downvoted"
    redirect_to :back
  end

  def edit
    
  end

  def show
    @comment = Comment.find(params[:id])
    render :show
  end

  def update
    
  end

  def upvote
    @comment = Comment.find(params[:id])
    @comment.upvotes += 1
    @comment.save
    flash[:notices] ||= []
    flash[:notices] << "comment upvoted"
    redirect_to :back
  end
end