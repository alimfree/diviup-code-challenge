class TaskListSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :complete

  def include_user?
    false
  end
end
