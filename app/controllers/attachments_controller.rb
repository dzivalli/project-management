class AttachmentsController < ApplicationController
  include Projectable

  def index
    @project = project { includes(:attachments) }
  end

  def new
    @attachment = Attachment.new
    @title = 'Загрузка файла'
    render layout: 'modal'
  end

  def create
    attachment = Attachment.new attachment_params.merge(user: current_user)
    store do
      Notifications.project_notice(attachment.file_identifier,
                                   current_user,
                                   'Добавление файла').deliver_later
      project.attachments << attachment
    end
  end

  def destroy
    attachment = project.attachments.find params[:id]
    if attachment.destroy
      redirect_to :back, notice: 'Файл удален успешно'
    end
  end

  private

  def attachment_params
    params.require(:attachment).permit(:file, :description)
  end
end
