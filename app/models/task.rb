class Task < ActiveRecord::Base
  belongs_to :user
  belongs_to :list

  validates :title, presence: true
  validates :complete, inclusion: { in: [true, false] }
  validates :complete, exclusion: { in: [nil] }

  validates :user_id, presence: true
  validates :list_id, presence: true
end
