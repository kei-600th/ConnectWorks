# spec/models/task_spec.rb
require 'rails_helper'

RSpec.describe Task, type: :model do
  describe 'validation' do
    # .buildだと関連するプロジェクトが作られないので.createを使ってください
    it 'is valid with a name, status, and project_id' do
      task = FactoryBot.create(:task)
      expect(task).to be_valid
    end

    it 'is invalid without a name' do
      task = FactoryBot.build(:task, name: nil)
      task.valid?
      expect(task.errors[:name]).to include("can't be blank")
    end

    it 'is invalid without a status' do
      task = FactoryBot.build(:task, status: nil)
      task.valid?
      expect(task.errors[:status]).to include("can't be blank")
    end

    it 'is invalid without a project_id' do
      task = FactoryBot.build(:task, project: nil)
      task.valid?
      expect(task.errors[:project]).to include("must exist")
    end
  end
end
