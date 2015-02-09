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
      @te.created_at = @te.updated_at = Time.now.strftime("%d-%m-%Y %H:%M")
      @title = 'Новый отрезок времени'
      @project = Project.includes(:tasks).find(params[:project_id])
      render layout: 'modal'
    end
  end

  def create
    te = TimeEntry.new(time_entry_params.merge!(user: current_user, status: 'completed'))
    if te.save
      redirect_to :back, notice: 'Время успешно добавлено'
    else
      redirect_to :back, alert: 'Произошла ошибка'
    end
  end

  def edit
    @te = TimeEntry.find params[:id]
    @te.created_at = @te.created_at.strftime("%d-%m-%Y %H:%M")
    @te.updated_at = @te.updated_at.strftime("%d-%m-%Y %H:%M")
    @title = 'Изменить отрезок времени'
    @project = Project.includes(:tasks).find(params[:project_id])
    render 'new', layout: 'modal'
  end

  def update
    if params.has_key?(:time_entry)
      te = TimeEntry.find params[:id]
        if te.update(time_entry_params)
          redirect_to :back, notice: 'Время обновленно успешно'
        else
          redirect_to :back, alert: 'Произошла ошибка'
        end
    else
      if TimeEntry.update(params[:id], status: 'completed')
        redirect_to :back, notice: 'Таймер остановлен успешно'
      end
    end
  end

  def destroy
    if TimeEntry.find(params[:id]).destroy
      redirect_to :back, notice: 'Временной отрезок был удален успешно'
    end
  end

  private

  def time_entry_params
    params.require(:time_entry).permit(:created_at, :updated_at, :task_id)
  end
end
