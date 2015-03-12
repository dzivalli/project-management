class Notifications < ApplicationMailer
  default from: 'email-tests@yandex.ru'
  layout false

  def signup(client)
    @client = client

    mail to: client.owner.email,
         subject: 'Регистрация'
  end

  def notice_invoice(invoice, template)
    body = EmailTemplate.for_client(invoice.company.client).find_by_name(template).body
    body.sub!('{{AMOUNT_DUE}}', invoice.amount_due.to_s)
    body.sub!('{{URL_TO_PAY}}', 'custom url')
    body.sub!('{{INVOICE}}', invoice.reference_no)
    body.sub!('{{SIGN}}', invoice.company.name)

    mail to: invoice.company.email,
         subject: template,
         body: body,
         content_type: 'text/html'
  end
end
