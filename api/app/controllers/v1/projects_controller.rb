class V1::ProjectsController < ApplicationController

  def index
    project = Project.all
    render json: project
  end

  def create
    project = Project.new(project_params)
    if project.save
      render json: project
    else
      render json: project.errors
    end
  end

  # ストロングパラメーターの設定
  def project_params
    params.require(:project).permit(:name)
  end




end
