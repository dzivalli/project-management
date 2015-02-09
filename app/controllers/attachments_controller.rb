class AttachmentsController < ApplicationController

  def index
    @project = Project.includes(:attachments).find params[:project_id]
  end

  def new
    @project = Project.find params[:project_id]
    @attachment = Attachment.new
    @title = 'Загрузка файла'
    render layout: 'modal'
  end

  def create
    attachment = Attachment.new attachment_params.merge(user: current_user, project_id: params[:project_id])
    if attachment.save
      redirect_to :back, notice: 'Файл загружен успешно'
    else
      redirect_to :back, alert: 'Произошла ошибка'
    end
  end

  def destroy
    attachment = Attachment.find params[:id]
    if attachment.destroy
      redirect_to :back, notice: 'Файл удален успешно'
    end
  end

  private

  def attachment_params
    params.require(:attachment).permit(:file, :description)
  end
end
