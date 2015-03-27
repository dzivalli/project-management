class AttachmentsController < ApplicationController
  include Projectable

  def index
    @project = find_project { includes(:attachments) }
  end

  def new
    @project = find_project
    @attachment = Attachment.new
    @title = 'Загрузка файла'
  end

  def create
    attachment = Attachment.new attachment_params.merge(user: current_user)
    project = find_project
    store do
      project.attachments << attachment
      Notifications.notice(project.name,
                           current_user.email,
                           'Добавление файла',
                           client).deliver_later
    end
  end

  def destroy
    attachment = find_project.attachments.find params[:id]
    if attachment.destroy
      redirect_to :back, notice: 'Файл удален успешно'
    end
  end

  private

  def attachment_params
    params.require(:attachment).permit(:file, :description)
  end
end
