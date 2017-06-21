class Link < ActiveRecord::Base
  belongs_to :user

  has_many :votes, dependent: :destroy

  validates :url, presence: true
  validates :description, presence: true
  validates :user_id, presence: true
end
