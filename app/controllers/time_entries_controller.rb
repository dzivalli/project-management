class TimeEntriesController < ApplicationController
  def index
    @project = Project.find params[:project_id]
    @time_entries = TimeEntry.for_project(@project)
  end

  def new
    if params[:task_id].present?
      te = TimeEntry.new(task: Task.find(params[:task_id]), user: current_user, status: 'active')
      if te.save
        redirect_to :back, notice: 'Таймер запущен успешно'
      end
    else
      @te = TimeEntry.new
      @title = 'Новый отрезок времени'
      @project = Project.includes(:tasks).find(params[:project_id])
      render layout: 'modal'
    end
  end

  def create

  end

  def update
    if TimeEntry.update(params[:id], status: 'completed')
      redirect_to :back, notice: 'Таймер остановлен успешно'
    end
  end
end
