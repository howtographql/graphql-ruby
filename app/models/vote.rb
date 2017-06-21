class Vote < ActiveRecord::Base
  belongs_to :user
  belongs_to :link

  validates :link_id, presence: true
  validates :user_id, presence: true, uniqueness: { scope: :link_id }
end
