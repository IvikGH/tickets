class CommentsController < ApplicationController

  skip_before_action :authenticate_user!, only: [:create]

  def create
    @comment = Comment.new(comment_params)
    @comment.user_id = current_user.id
    @comment.ticket_id = params[:ticket_id]

    if @comment.save
      flash.now[:message] = 'Your comment was successfully created.'
    else
      flash[:error] = @comment.errors.messages.to_s
    end

    CommentsMailer.new_comment_inform(@comment, current_user).deliver_later
    redirect_to @comment.ticket
  end

  private

  def comment_params
    params.require(:comment).permit(:body, :ticket_id)
  end
end
