# spec/models/project_spec.rb
require 'rails_helper'

RSpec.describe Project, type: :model do
  describe 'validation' do
    # ここにバリデーションのテストを記述

    it 'is valid with a name' do
      project = FactoryBot.build(:project)
      expect(project).to be_valid
    end

    it 'is invalid without a name' do
      project = FactoryBot.build(:project, name: nil)
      project.valid?
      expect(project.errors[:name]).to include("can't be blank")
    end
  end

  describe 'associations' do
    let!(:project) { FactoryBot.create(:project) }
    let!(:task1) { FactoryBot.create(:task, project: project) }
    let!(:task2) { FactoryBot.create(:task, project: project) }

    it 'deletes associated tasks when destroyed' do
      expect { project.destroy }.to change { Task.count }.by(-2)
    end
  end
end
