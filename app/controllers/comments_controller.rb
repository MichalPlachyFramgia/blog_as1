class CommentsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]
  before_action :correct_user,   only: :destroy

  def show
    @comment = Comment.find(params[:id])
  end

  def create
    @comment = current_user.comments.build(comment_params)
    if @comment.save
      redirect_to :back
    else
      redirect_to :back
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    flash[:success] = "comment deleted"
    redirect_to request.referrer || root_url
  end

  private

    def comment_params
      params.require(:comment).permit(:content, :picture, :entry_id)
    end

    def correct_user
      @comment = current_user.comments.find_by(id: params[:id])
      redirect_to :back if @comment.nil?
    end
end
