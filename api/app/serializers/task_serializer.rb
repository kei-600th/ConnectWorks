class TaskSerializer < ActiveModel::Serializer
  attributes :id, :name, :status, :describe, :project_id
  belongs_to :project
end
