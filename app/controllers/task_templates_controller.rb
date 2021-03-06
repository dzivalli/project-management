class TaskTemplatesController < ApplicationController
  def new
    @title = 'Новый шаблон задачи'
    @task_template = TaskTemplate.new
    render layout: 'modal'
  end

  def create
    task_template = TaskTemplate.new task_template_params.merge(client: client)
    store do
      task_template.save
    end
    flash[:from] = 'task'
  end

  def edit
    @title = 'Изменить шаблон'
    @task_template = TaskTemplate.for_client(client).find params[:id]
    render 'new', layout: 'modal'
  end

  def update
    task_template = TaskTemplate.for_client(client).find params[:id]
    renew do
      task_template.update task_template_params
    end
    flash[:from] = 'task'
  end

  def destroy
    task_template = TaskTemplate.for_client(client).find params[:id]
    if task_template.destroy
      redirect_to :back, notice: 'Шаблон удален'
    end
  end
  private

  def task_template_params
    params.require(:task_template).permit(:name, :description, :visible, :estimated_hours)
  end
end
