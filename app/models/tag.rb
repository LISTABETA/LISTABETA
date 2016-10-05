class Tag < ActiveRecord::Base
  include PgSearch

  pg_search_scope :search, against: :name,
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
end
