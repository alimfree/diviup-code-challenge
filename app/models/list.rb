class List < ActiveRecord::Base
  validates :title, :user_id, presence: true

  belongs_to :user
  has_many :tasks, dependent: :destroy

end
