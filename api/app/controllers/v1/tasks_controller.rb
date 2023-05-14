class V1::TasksController < ApplicationController
  def index
    task = Task.all
    render json: task
  end

  def create
    task = Task.new(task_params)
    if task.save
      # 成功した場合にはHTTPステータスコード 201 Created をクライアントに返す
      render json: task, status: :created
    else
      # 失敗した場合にはHTTPステータスコード 422 Unprocessable Entity をクライアントに返す
      render json: task.errors, status: :unprocessable_entity
    end
  end

  def update
    task = Task.find(params[:id])
    if task.update(task_params)
      # 成功した場合にはHTTPステータスコード 201 Created をクライアントに返す
      render json: task, status: :created
    else
      # 失敗した場合にはHTTPステータスコード 422 Unprocessable Entity をクライアントに返す
      render json: task.errors, status: :unprocessable_entity
    end
  end

  # ストロングパラメーターの設定
  def task_params
    params.require(:task).permit(:name, :status, :describe, :project_id)
  end
end
