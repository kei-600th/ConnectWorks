# spec/controllers/tasks_controller_spec.rb

require 'rails_helper'

RSpec.describe V1::TasksController, type: :controller do
  # POST #createアクションのテスト
  describe 'POST #create' do
    # 有効な属性を持つタスクの作成についてのテスト
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

    # 無効な属性を持つタスクの作成についてのテスト
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

  # GET #indexアクションのテスト
  describe 'GET #index' do
    # すべてのタスクが正しく返されることを検証するテストケース
    it 'returns all tasks' do
      create_list(:task, 5)
      get :index
      json = JSON.parse(response.body)
      expect(json).not_to be_empty
      expect(json.size).to eq(5)
    end
  end

  # PUT #updateアクションのテスト
  describe 'PUT #update' do
    let(:task) { create(:task) }
    let(:new_name) { 'New Task Name' }

    # 有効な属性を持つタスクの更新についてのテスト
    context 'with valid attributes' do
      # 有効な属性が与えられた場合、タスクが更新されることを検証するテストケース
      it 'updates the task' do
        put :update, params: { id: task.id, task: { name: new_name } }
        task.reload
        expect(task.name).to eq(new_name)
      end
    end

    # 無効な属性を持つタスクの更新についてのテスト
    context 'with invalid attributes' do
      # 無効な属性が与えられた場合、タスクが更新されないことを検証するテストケース
      it 'does not update the task' do
        put :update, params: { id: task.id, task: { name: nil } }
        task.reload
        expect(task.name).not_to be_nil
      end
    end
  end

  # DELETE #destroyアクションのテスト
  describe 'DELETE #destroy' do
    let!(:task) { create(:task) }

    # タスクが正常に削除されることを検証するテストケース
    it 'deletes the task' do
      expect do
        delete :destroy, params: { id: task.id }
      end.to change(Task, :count).by(-1)
    end
  end
end