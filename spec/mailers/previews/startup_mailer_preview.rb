# Preview all emails at http://localhost:3000/rails/mailers/
class StartupMailerPreview < ActionMailer::Preview
  def notify_approvation
    startup = Startup.last
    StartupMailer.notify_approvation(startup)
  end

  def notify_unapprovation
    startup = Startup.last
    StartupMailer.notify_unapprovation(startup)
  end

  def notify_publication
    startup = Startup.last
    StartupMailer.notify_publication(startup)
  end
end
