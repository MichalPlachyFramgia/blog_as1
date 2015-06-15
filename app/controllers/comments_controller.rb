class CommentsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]
  before_action :correct_user,   only: :destroy

  def create
    @comment = current_user.comments.build(comment_params)
    if @comment.save
      redirect_to :back
    else
      @feed_items = []
      redirect_to :back
    end
  end

def destroy
    @comment.destroy
    flash[:success] = "comment deleted"
    redirect_to :back
  end

  private

    def comment_params
      params.require(:comment).permit(:title, :content, :picture)
    end

     def correct_user
      @comment = current_user.entries.find_by(id: params[:id])
      redirect_to :back if @comment.nil?
    end
end
