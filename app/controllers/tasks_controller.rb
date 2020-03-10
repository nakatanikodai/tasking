class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  def index
    @q = current_user.tasks.ransack(params[:q])
    @tasks = @q.result(distinct:true)
  end

  def show
  end

  def new
    @task = Task.new
  end

  def edit
  end

  def update
    @task = current_user.tasks.new(task_params)

    if @task.save
      redirect_to tasks_url, notice: "タスク「#{@task.name}」を更新しました。"
    else
      redirect_to @task, notice:"30文字以内で登録してください"
    end
    #@task.update!(task_params)
    #redirect_to tasks_url, notice: "タスク「#{@task.name}」を更新しました。"
  end

  def destroy
    @task.destroy
    redirect_to tasks_url, notice: "タスク「#{@task.name}」を削除しました"
  end

  def create
    @task = current_user.tasks.new(task_params)

    if params[:back].present?#確認画面の挿入
      render :new
      return
    end

    if @task.save
      redirect_to @task, notice: "タスク「#{@task.name}」を登録しました。"
    else
      redirect_to @task, notice: "30文字以内で登録してください。"
    end
  end

  def confirm_new
    @task = current_user.tasks.new(task_params)
    render :new unless @task.valid?
  end



  private

  def task_params
    params.require(:task).permit(:name, :description)
  end

  def set_task
    @task = current_user.tasks.find(params[:id])
  end
end