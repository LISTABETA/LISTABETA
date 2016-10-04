class Startup < ActiveRecord::Base
  extend FriendlyId
  include PgSearch
  friendly_id :name, use: :slugged

  acts_as_ordered_taggable
  acts_as_ordered_taggable_on :markets

  belongs_to :user

  has_enumeration_for :status, create_helpers: true
  has_enumeration_for :phase, create_helpers: true

  mount_uploader :screenshot, ScreenshotUploader

  validates :email, :name, :website, :pitch, :description, :screenshot, :phase,
            :state, :city, :market_list, presence: true
  validates :website, url: true
  validates :pitch, length: { in: 30..140 }
  validates :description, length: { in: 50..1024 }

  # Normal scopes
  scope :draft, -> { where(status: Status::DRAFT) }
  scope :pending, -> { where(status: Status::PENDING) }
  scope :approved, -> { where(status: Status::APPROVED) }
  scope :unapproved, -> { where(status: Status::UNAPPROVED) }
  scope :highlighteds, -> { where(highlighted: true, status: Status::APPROVED) }
  scope :unhighlighteds, -> { where(highlighted: false, status: Status::APPROVED) }
  scope :order_by_approvement, -> { order("approved_at DESC") }
  scope :order_by_highlighted_at, -> { order ("highlighted_at DESC")}

  # PgSearch scopes (:tsearch = builtin Full-text Search)
  pg_search_scope :by_title, against: :name,
                             ignoring: :accents,
                             using: {
                               trigram: {
                                 threshold: 0.2
                               },
                               tsearch: {
                                 prefix: true,
                                 any_word: true
                               }
                             }

  def highlight!
    update_attributes(highlighted: true,
                      highlighted_at: DateTime.now)
  end

  def unhighlight!
    update_attributes(highlighted: false,
                      highlighted_at: nil)
  end

  def submit!
    return if !status.eql?(Status::DRAFT)

    update_attributes(status: Status::PENDING)
  end

  def approve!
    return if !status.eql?(Status::PENDING)

    if update_attributes(status: Status::APPROVED, approved_at: DateTime.now)
      StartupMailer.notify_approvation(self).deliver
    end
  end

  def unapprove!
    return if !status.eql?(Status::PENDING)

    if update_attributes(status: Status::UNAPPROVED, approved_at: nil)
      StartupMailer.notify_unapprovation(self).deliver
    end
  end
end
