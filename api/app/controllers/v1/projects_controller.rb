class V1::ProjectsController < ApplicationController
  def index
    project = Project.all
    render json: project
  end

  def create
    project = Project.new(project_params)
    if project.save
      # 成功した場合にはHTTPステータスコード 201 Created をクライアントに返す
      render json: project, status: :created
    else
      # 失敗した場合にはHTTPステータスコード 422 Unprocessable Entity をクライアントに返す
      render json: project.errors, status: :unprocessable_entity
    end
  end

  # ストロングパラメーターの設定
  def project_params
    params.require(:project).permit(:name)
  end
end
