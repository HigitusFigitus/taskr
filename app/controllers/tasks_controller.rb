class TasksController < ApplicationController
  before_action :authenticate_user!
  before_action :find_task, only: [:edit, :update, :show, :destroy, :update_state]

  def index
    @to_do = current_user.tasks.where(state: 'to_do')
    @doing = current_user.tasks.where(state: 'doing')
    @done = current_user.tasks.where(state: 'done')
  end

  def new
    @task = Task.new
  end

  def edit
  end

  def create
    @task = current_user.tasks.new(tasks_params)
    if @task.save
      flash[:notice] = "Task was successfully created."
      redirect_to task_path(@task)
    else
      render 'new'
    end
  end

  def update
    if @task.update(tasks_params)
      flash[:notice] = "The task was updated."
      redirect_to task_path(@task)
    else
      render 'edit'
    end
  end

  def show
  end

  def destroy
    @task.destroy
    flash[:notice] = "The task was deleted."
    redirect_to tasks_path
  end

  def update_state
    task.update_attributes(state: params[:state])
    flash[:notice] = "Task successfully updated."
    redirect_to tasks_path
  end

private
  def find_task
    @task = Task.find(params[:id])
  end

  def tasks_params
    params.require(:task).permit(:content, :state)
  end
end