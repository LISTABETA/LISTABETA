class StartupMailer < ActionMailer::Base
  default from: "noreply@listabeta.com.br"
  layout 'mailer'

  def notify_approvation(startup)
    @startup = startup
    mail to: @startup.user.email, subject: 'Aprovação na LISTABETA'
  end

  def notify_unapprovation(startup)
    @startup = startup
    mail to: @startup.user.email, subject: 'Reprovação na LISTABETA!'
  end

  def notify_publication(startup)
    @startup = startup
    mail to: @startup.user.email, subject: 'Publicação na LISTABETA!'
  end
end
