class Link < ActiveRecord::Base
  # For ruby tutorial purposes. In Authentication Chapter, when connecting users to links, 
  # Error message 'ActiveRecord::RecordInvalid (Validation failed: User must exist):'
  # If you're on Rails 5, you'll need to update your user association to:
  # belongs_to :user, optional: true
  belongs_to :user, validate: true

  has_many :votes, dependent: :destroy

  validates :url, presence: true, url: true, length: { minimum: 3 }
  validates :description, presence: true, length: { minimum: 3 }

  scope :like, ->(field, value) { where arel_table[field].matches("%#{value}%") }
end
