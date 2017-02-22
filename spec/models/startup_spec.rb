require 'spec_helper'

RSpec.describe Startup, type: :model do
  describe "Validations" do
    it { should validate_presence_of :name }
    it { should validate_presence_of :website }
    it { should validate_presence_of :pitch }
    it { should validate_presence_of :description }
    it { should validate_presence_of :screenshot }
    it { should validate_presence_of :state }
    it { should validate_presence_of :city }
    it { should validate_presence_of :market_list }
    it { should validate_uniqueness_of :slug }
    it { should validate_length_of(:pitch).is_at_least(20).is_at_most(75) }
    it { should validate_length_of(:description).is_at_least(50).is_at_most(500) }
  end

  describe "URL validation" do
    it { should allow_value('http://lists.gnupg.org/pipermail/gnupg-announce/2013q4/000334.html').for(:website) }
    it { should allow_value('https://lists.gnupg.org/pipermail/gnupg-announce/2013q4/000334.html').for(:website) }
    it { should allow_value('http://www.lists.gnupg.org/pipermail/gnupg-announce/2013q4/000334.html').for(:website) }
    it { should allow_value('https://www.lists.gnupg.org/pipermail/gnupg-announce/2013q4/000334.html').for(:website) }

    it { should_not allow_value('lists.gnupg.org/pipermail/gnupg-announce/2013q4/000334.html').for(:website) }
    it { should_not allow_value('lists. gnupg.org/pipermail/gnupg-announce/2013q4/000334.dehtml').for(:website) }
    it { should_not allow_value('http://lists. gnupg.org/pipermail/gnupg-announce/2013q4/000334.html').for(:website) }
    it { should_not allow_value("\n").for(:website) }
    it { should_not allow_value('a space').for(:website) }
    it { should_not allow_value("blank\nline").for(:website) }
  end

  describe "Relations" do
    it { should belong_to :user }
  end

  describe "Scopes" do
    context "#highlighted" do
      let(:startup_1) { create(:startup, :published, :highlighted) }
      let(:startup_2) { create(:startup, :approved, :highlighted) }
      let(:startup_3) { create(:startup, :pending) }

      it "return only the highlighted startups that are approved" do
        expect(Startup.highlighteds).to include(startup_1)
        expect(Startup.highlighteds).to_not include(startup_2)
        expect(Startup.highlighteds).to_not include(startup_3)
      end
    end

    context "#unhighlighted" do
      let(:startup_1) { create(:startup, :published) }
      let(:startup_2) { create(:startup, :published) }
      let(:startup_3) { create(:startup, :published, :highlighted) }

      it "return only the unhighlighted startups" do
        expect(Startup.unhighlighteds).to include(startup_1)
        expect(Startup.unhighlighteds).to include(startup_2)
        expect(Startup.unhighlighteds).to_not include(startup_3)
      end
    end

    context "#approved" do
      let(:startup_1) { create(:startup, :approved) }
      let(:startup_2) { create(:startup, :approved) }
      let(:startup_3) { create(:startup, :unapproved) }

      it "return only the approved startups" do
        expect(Startup.approved).to include(startup_1)
        expect(Startup.approved).to include(startup_2)
        expect(Startup.approved).to_not include(startup_3)
      end
    end

    context "#unapproved" do
      let(:startup_1) { create(:startup, :unapproved) }
      let(:startup_2) { create(:startup, :unapproved) }
      let(:startup_3) { create(:startup, :approved) }

      it "return only the unhighlighted startups" do
        expect(Startup.unapproved).to include(startup_1)
        expect(Startup.unapproved).to include(startup_2)
        expect(Startup.unapproved).to_not include(startup_3)
      end
    end

    context "#published" do
      let(:startup_1) { create(:startup, :published) }
      let(:startup_2) { create(:startup, :published) }
      let(:startup_3) { create(:startup, :approved) }

      it "return only the published startups" do
        expect(Startup.published).to include(startup_1)
        expect(Startup.published).to include(startup_2)
        expect(Startup.published).to_not include(startup_3)
      end
    end
  end

  describe "Methods" do
    context "#highlight!" do
      let(:startup_unhighlight) { create(:startup, :published) }
      let(:startup_highlight) { create(:startup, :published, :highlighted) }

      it "set when is unhighlighted" do
        startup_unhighlight.highlight!
        expect(startup_unhighlight.highlighted).to be_truthy
      end

      it "do nothing when already highlighted" do
        startup_highlight.highlight!
        expect(startup_highlight.highlighted).to be_truthy
      end

      it "set highlighted_at to DateTime.now when unhighlighted" do
        expected = DateTime.now
        DateTime.stub(:now).and_return(expected)
        expect {
          startup_unhighlight.highlight!
        }.to change(startup_unhighlight, :highlighted_at).from(nil).to(expected)
      end
    end

    context "#unhighlight!" do
      let(:startup_unhighlight) { create(:startup, :published) }
      let(:startup_highlight) { create(:startup, :published, :highlighted) }

      it "set when is highlighted" do
        startup_highlight.unhighlight!
        expect(startup_highlight.highlighted).to be_falsey
      end

      it "do nothing when already unhighlighted" do
        startup_highlight.unhighlight!
        expect(startup_highlight.highlighted).to be_falsey
      end
    end

    context "#approve!" do
      let(:startup_pending) { create(:startup, :pending) }
      let(:approved_datetime) { DateTime.new(2013, 11, 20, 12, 00) }
      let(:startup_approved) do
        create(:startup, :published, :highlighted,
               approved_at: approved_datetime)
      end

      before do
        startup_pending.approve!
        startup_pending.reload
      end

      it { expect(startup_pending.status).to eql(Status::APPROVED) }
      it { expect(startup_pending.approved_at).to_not be_nil }

      it "send mail after approve!" do
        expect(ActionMailer::Base.deliveries.last.to).to include(
          startup_pending.user.email
        )
      end
    end

    context "#disapprove!" do
      let(:startup_pending) { create(:startup, :pending) }

      before do
        startup_pending.disapprove!
        startup_pending.reload
      end

      it { expect(startup_pending.status).to eql(Status::UNAPPROVED) }
      it { expect(startup_pending.approved_at).to be_nil }
    end

    context "#publish!" do
      let(:startup_approved) { create(:startup, :approved) }

      before do
        startup_approved.publish!
        startup_approved.reload
      end

      it { expect(startup_approved.status).to eql(Status::PUBLISHED) }
      it { expect(startup_approved.published_at).to_not be_nil }

      it "send mail after publish!" do
        expect(ActionMailer::Base.deliveries.last.to).to include(
          startup_approved.user.email
        )
      end
    end
  end
end
