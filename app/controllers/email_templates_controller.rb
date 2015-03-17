class EmailTemplatesController < ApplicationController
  before_action :find_group, except: :update

  def index
    @group =  params[:group] || 'Счета'
    group = EmailTemplate.groups[@group]
    @tabs = EmailTemplate.for_client_by_group(client, group).select(:id, :name)
    @email_template = EmailTemplate.for_client_by_group(client, group).first
    render 'show'
  end

  def show
    @email_template = EmailTemplate.for_client(client).find params[:id]
    @group = @email_template.group
    @tabs = EmailTemplate.for_client_by_group(client, EmailTemplate.groups[@group]).select(:id, :name)
  end

  def update
    email_template = EmailTemplate.for_client(client).find params[:id]
    renew do
      email_template.update(body: params[:email_template][:body])
    end
  end

  private

  def find_group
    @groups = EmailTemplate.groups.except('Клиенты').keys
  end

end
