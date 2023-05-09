class Task < ApplicationRecord
  validates :name, presence: true
  validates :status, presence: true
  validates :project_id, presence: true
  belongs_to :project
end