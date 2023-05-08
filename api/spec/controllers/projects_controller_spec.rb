# spec/controllers/projects_controller_spec.rb
require 'rails_helper'

RSpec.describe V1::ProjectsController, type: :controller do
  describe 'POST #create' do
    # ここにプロジェクト登録機能のテストを記述


    context 'with valid attributes' do
      let(:project_params) { attributes_for(:project) }
    
      it 'creates a new project' do
        expect {
          post :create, params: { project: project_params }
        }.to change(Project, :count).by(1)
      end


    context 'with invalid attributes' do
      let(:invalid_project_params) { attributes_for(:project, name: nil) }
    
      it 'does not create a new project' do
        expect {
          post :create, params: { project: invalid_project_params }
        }.not_to change(Project, :count)
      end
    
    end


    end

  end




end
