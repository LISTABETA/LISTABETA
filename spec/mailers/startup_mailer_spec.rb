require "spec_helper"

describe StartupMailer, type: :mailer do
  let(:startup) { build_stubbed(:startup, :published, name: 'Startup de teste') }

  describe "notify_approvation" do
    let(:mail) { StartupMailer.notify_approvation(startup) }

    # ensure that the receiver is correct
    it "renders the receiver email" do
      expect(mail.to).to eq [startup.user.email]
    end

    # ensure that the sender is correct
    it "renders the sender email" do
      expect(mail.from).to eq ["noreply@listabeta.com.br"]
    end

    # ensure that the subject is correct
    it "renders the subject" do
      expect(mail.subject).to eq "Aprovação na LISTABETA"
    end
  end

  describe "notify_unapprovation" do
    let(:mail) { StartupMailer.notify_unapprovation(startup) }

    # ensure that the receiver is correct
    it "renders the receiver email" do
      expect(mail.to).to eq [startup.user.email]
    end

    # ensure that the sender is correct
    it "renders the sender email" do
      expect(mail.from).to eq ["noreply@listabeta.com.br"]
    end

    # ensure that the subject is correct
    it "renders the subject" do
      expect(mail.subject).to eq "Reprovação na LISTABETA!"
    end
  end

  describe "notify_publication" do
    let(:mail) { StartupMailer.notify_publication(startup) }

    # ensure that the receiver is correct
    it "renders the receiver email" do
      expect(mail.to).to eq [startup.user.email]
    end

    # ensure that the sender is correct
    it "renders the sender email" do
      expect(mail.from).to eq ["noreply@listabeta.com.br"]
    end

    # ensure that the subject is correct
    it "renders the subject" do
      expect(mail.subject).to eq "Publicação na LISTABETA!"
    end

    # ensure that body contain the url for the startup page
    it 'render the Startup URL' do
      expect(mail.body.include?(startup_url(startup))).to be true
    end
  end
end
