class TasksController < ApplicationController
  before_action :find_task, only: [:show, :edit, :update, :destroy, :complete]

  def index
    if user_signed_in?
      @tasks = Task.where(:user_id => current_user.id).order("created_at DESC")
    end
  end

  def show
  end

  def new
    @task = current_user.tasks.build
  end

  def create
    @task = current_user.tasks.build(task_params)
    if @task.save
      redirect_to root_path
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @task.update(task_params)
      redirect_to task_path(@task)
    else
      render 'edit'
    end
  end

  def destroy
    @task.destroy
    redirect_to root_path
  end

  def complete
    @task.update_attribute(:completed_at, Time.now)
    redirect_to root_path
  end

  private

  def task_params
    params.require(:task).permit(:title, :description)
  end

  def find_task
    @task = Task.find(params[:id])
  end
end
