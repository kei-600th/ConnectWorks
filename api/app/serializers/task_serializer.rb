class TaskSerializer < ActiveModel::Serializer
  attributes :id, :name, :status, :project_id
  belongs_to :project
end
