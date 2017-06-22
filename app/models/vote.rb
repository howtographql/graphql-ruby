class Vote < ActiveRecord::Base
  belongs_to :user, validate: true
  belongs_to :link, validate: true

  validates :user_id, uniqueness: { scope: :link_id }
end
