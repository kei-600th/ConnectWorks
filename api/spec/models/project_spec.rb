# spec/models/project_spec.rb

require 'rails_helper'

RSpec.describe Project, type: :model do
  describe 'validation' do
    # プロジェクトが有効であることを検証するテストケース
    it 'is valid with a name' do
      project = FactoryBot.build(:project)
      expect(project).to be_valid
    end

    # 名前がない場合にプロジェクトが無効であることを検証するテストケース
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

    # プロジェクトが削除されたときに関連するタスクも削除されることを検証するテストケース
    it 'deletes associated tasks when destroyed' do
      expect { project.destroy }.to change { Task.count }.by(-2)
    end
  end
end
