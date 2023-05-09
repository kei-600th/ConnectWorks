class V1::TasksController < ApplicationController
  def index
    task = Task.all
    render json: project
  end

  def create
    # task = Task.new(task_params)

  end

  # ストロングパラメーターの設定
  def task_params
    params.require(:task).permit(:name,:status,:project_id)
  end
end



end
