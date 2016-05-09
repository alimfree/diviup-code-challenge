class TaskSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :complete

  has_one :user
  has_one :list
end
