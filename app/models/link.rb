class Link < ActiveRecord::Base
  belongs_to :user, validate: true

  has_many :votes, dependent: :destroy

  validates :url, presence: true, url: true, length: { minimum: 3 }
  validates :description, presence: true, length: { minimum: 3 }

  scope :like, ->(field, value) { where arel_table[field].matches("%#{value}%") }
end
