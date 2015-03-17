class Notifications < ApplicationMailer
  default from: 'email-tests@yandex.ru'
  layout false

  def client_notice(client, template)
    body = get_body EmailTemplate.client_notices.find_by_name(template)
    body.sub!('{{URL}}', edit_client_url(client, token: client.owner.confirmation_token))

    mail to: client.owner.email,
         subject: template,
         body: body,
         content_type: 'text/html'
  end

  def notice_invoice(invoice, template)
    body = get_body EmailTemplate.for_client(invoice.company.client).find_by_name(template)
    body.sub!('{{AMOUNT_DUE}}', invoice.amount_due.to_s)
    body.sub!('{{URL_TO_PAY}}', 'custom url')
    body.sub!('{{INVOICE}}', invoice.reference_no)
    body.sub!('{{SIGN}}', invoice.company.name)

    mail to: invoice.company.email,
         subject: template,
         body: body,
         content_type: 'text/html'
  end

  def notice(name, email, template, client)
    body = get_body EmailTemplate.for_client(client).find_by_name(template)
    body.sub!('{{NAME}}', name)

    mail to: email,
         subject: template,
         body: body,
         content_type: 'text/html'
  end

  private

  def get_body(email)
    email ? email.body : ''
  end
end
