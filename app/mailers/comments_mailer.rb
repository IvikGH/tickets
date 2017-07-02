class CommentsMailer < ApplicationMailer

  def new_comment_inform(comment, comment_author)
    @ticket = comment.ticket
    @comment = comment
    @comment_author = comment_author

    mail(to: @ticket.employee_email,
         subject: "New comment for #{@ticket.uniq_reference} ticket")
  end
end
