class DefaultEmailsController < ApplicationController
  def index
    @group =  params[:group] || 'Счета'
    group = EmailTemplate.groups[@group]
    @groups = EmailTemplate.groups.keys
    @tabs = EmailTemplate.for_client_by_group(nil, group).select(:id, :name)
    @email_template = EmailTemplate.for_client_by_group(nil, group).first
    render 'show'
  end

  def show
    @email_template = EmailTemplate.find params[:id]
    @group = @email_template.group
    @groups = EmailTemplate.groups.keys
    @tabs = EmailTemplate.for_client_by_group(nil, EmailTemplate.groups[@group]).select(:id, :name)
  end

  def update
    email_template = EmailTemplate.find params[:id]
    renew do
      email_template.update(body: params[:email_template][:body])
    end
  end
end
