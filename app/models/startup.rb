class Startup < ActiveRecord::Base
  extend FriendlyId
  include PgSearch
  friendly_id :name, use: :slugged

  acts_as_ordered_taggable
  acts_as_ordered_taggable_on :markets

  belongs_to :user

  has_enumeration_for :status, create_helpers: true

  mount_uploader :screenshot, ScreenshotUploader

  validates :name, :website, :pitch, :description, :screenshot,
            :state, :city, :market_list, :slug, :market_list,
            :demonstration, presence: true
  validates :slug, uniqueness: true
  validates :website, url: true
  validates :pitch, length: { in: 20..75 }
  validates :description, length: { in: 50..500 }
  validate :has_at_least_one_market?

  # Normal scopes
  scope :draft, -> { where(status: Status::DRAFT) }
  scope :pending, -> { where(status: Status::PENDING) }
  scope :approved, -> { where(status: Status::APPROVED) }
  scope :published, -> { where(status: Status::PUBLISHED) }
  scope :unapproved, -> { where(status: Status::UNAPPROVED) }
  scope :highlighteds, -> { where(highlighted: true, status: Status::PUBLISHED) }
  scope :unhighlighteds, -> { where(highlighted: false, status: Status::PUBLISHED) }
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
      StartupMailer.notify_approvation(self).deliver_now
    end
  end

  def publish!
    return if !status.eql?(Status::APPROVED)

    if update_attributes(status: Status::PUBLISHED, published_at: DateTime.now)
      StartupMailer.notify_publication(self).deliver_now
    end
  end

  def unapprove!
    return if !status.eql?(Status::PENDING)

    if update_attributes(status: Status::UNAPPROVED, approved_at: nil)
      StartupMailer.notify_unapprovation(self).deliver_now
    end
  end

  private

  def has_at_least_one_market?
    errors.add(:market_list, "deve possuir ao menos 1 mercadi") unless market_list.count > 0
  end
end
