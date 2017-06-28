class ApplicationMailer < ActionMailer::Base
  default from: 'ticket@board.com'
  layout 'mailer'
end
