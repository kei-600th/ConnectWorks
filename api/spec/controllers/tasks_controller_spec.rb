# spec/controllers/tasks_controller_spec.rb

require 'rails_helper'

RSpec.describe V1::TasksController, type: :controller do
  describe 'POST #create' do
    context 'with valid attributes' do
      let(:project) { create(:project) }
      let(:task_params) { attributes_for(:task).merge(project_id: project.id) }

      # 有効な属性が与えられた場合、新しいタスクが作成されることを検証するテストケース
      it 'creates a new task' do
        expect do
          post :create, params: { task: task_params }
        end.to change(Task, :count).by(1)
      end
    end

    context 'with invalid attributes' do
      let(:invalid_task_params) { attributes_for(:task, name: nil) }

      # 無効な属性が与えられた場合、新しいタスクが作成されないことを検証するテストケース
      it 'does not create a new task' do
        expect do
          post :create, params: { task: invalid_task_params }
        end.not_to change(Task, :count)
      end
    end
  end
end
