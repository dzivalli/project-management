class TasksController < ApplicationController
  include ProjectCommon

  def index
    @project = Project.includes(:tasks).find params[:project_id]
  end

  def new
    @task = @project.tasks.build
    @title = 'Новая задача'
    @milestones = Milestone.all
    @users = User.all
    render layout: 'modal'
  end

  def create
    task = Task.new_or_upd_with_users permitted(params), params[:project_id]
    if task.save
      redirect_to :back, notice: 'Задача создано успешно'
    else
      redirect_to :back, alert: 'Произошла ошибка'
    end
  end

  def edit
    @task = Task.find params[:id]
    @title = 'Измениить данные'
    @milestones = Milestone.all
    @users = User.all
    render 'new', layout: 'modal'
  end

  def update
    task = Task.new_or_upd_with_users permitted(params), params[:project_id],
                                      params[:id]
    if task.save
      redirect_to :back, notice: 'Задача обновленна успешно'
    else
      redirect_to :back, alert: 'Произошла ошибка'
    end
  end

  def show
    @task = Task.find params[:id]
  end

  def destroy
  end

  private

  def permitted(params)
    params.require(:task).permit(:name, :description, :estimated_hours,
                                 :due_date, :milestone_id, :visible,
                                 :progress, :added_by, users: [])
  end
end
