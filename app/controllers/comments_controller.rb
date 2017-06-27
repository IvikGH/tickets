class CommentsController < ApplicationController

  skip_before_action :authenticate_user!, only: [:create]

  def create
    @comment = Comment.new(comment_params)
    @comment.user_id = current_user.id
    @comment.ticket_id = params[:ticket_id]

    respond_to do |format|
      if @comment.save
        flash.now[:message] = 'Your comment was successfully created.'
      else
        flash[:error] = @comment.errors.messages.to_s
      end
      format.html { redirect_to @comment.ticket }
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:body, :ticket_id)
  end
end