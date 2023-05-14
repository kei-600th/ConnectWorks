class V1::TasksController < ApplicationController
  def index
    task = Task.all
    render json: task
  end

  def create
    task = Task.new(task_params)
    if task.save
      render json: task, status: :created
    else
      render json: task.errors, status: :unprocessable_entity
    end
  end

  def update
    task = Task.find(params[:id])
    if task.update(task_params)
      render json: task, status: :ok
    else
      render json: task.errors, status: :unprocessable_entity
    end
  end

  def destroy
    task = Task.find(params[:id])
    if task.delete
      head :no_content
    else
      render json: task.errors, status: :unprocessable_entity
    end
  end

  # ストロングパラメーターの設定
  def task_params
    params.require(:task).permit(:name, :status, :describe, :project_id)
  end
end
