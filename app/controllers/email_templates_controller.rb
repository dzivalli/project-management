class EmailTemplatesController < ApplicationController
  def index
    @group =  params[:group] || 'Счета'
    group = EmailTemplate.groups[@group]
    @groups = EmailTemplate.groups.keys
    @tabs = EmailTemplate.for_client_by_group(client, group).select(:id, :name)
    @email_template = EmailTemplate.for_client_by_group(client, group).first
    render 'show'
  end

  def show
    @email_template = EmailTemplate.for_client(client).find params[:id]
    @groups = EmailTemplate.groups.keys
    @tabs = EmailTemplate.for_client_by_group(client, @email_template.group).select(:id, :name)
    @group = @email_template.group
  end

  def update
    email_template = EmailTemplate.for_client(client).find params[:id]
    renew do
      email_template.update(body: params[:email_template][:body])
    end
  end

end
