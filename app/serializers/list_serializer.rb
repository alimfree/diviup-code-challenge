class ListSerializer < ActiveModel::Serializer
  attributes :id, :title, :description

  has_one :user
  has_many :tasks, serializer: TaskListSerializer

end
