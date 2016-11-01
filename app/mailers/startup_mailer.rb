class StartupMailer < ActionMailer::Base
  default from: "noreply@listabeta.com.br"

  def notify_approvation(startup)
    @startup = startup
    mail to: @startup.user.email, subject: 'Aprovação no LISTABETA'
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
