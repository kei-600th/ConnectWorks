# spec/controllers/projects_controller_spec.rb

require 'rails_helper'

RSpec.describe V1::ProjectsController, type: :controller do
  describe 'POST #create' do
    # プロジェクト作成機能のテストケース

    context 'with valid attributes' do
      let(:project_params) { attributes_for(:project) }

      it 'creates a new project' do
        expect do
          post :create, params: { project: project_params }
        end.to change(Project, :count).by(1)
      end
    end

    context 'with invalid attributes' do
      let(:invalid_project_params) { attributes_for(:project, name: nil) }

      # 無効な属性が与えられた場合、新しいプロジェクトが作成されないことを検証するテストケース
      it 'does not create a new project' do
        expect do
          post :create, params: { project: invalid_project_params }
        end.not_to change(Project, :count)
      end
    end
  end
end
