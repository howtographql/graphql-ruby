class Link < ActiveRecord::Base
  belongs_to :user, validate: true

  has_many :votes, dependent: :destroy

  validates :url, presence: true, url: true
  validates :description, presence: true
end
