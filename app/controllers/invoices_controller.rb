class InvoicesController < ApplicationController
  def index
    @invoices = Invoice.client_invoices(client)
  end

  def new
    @invoice = Invoice.new(due_date: Time.now.strftime("%d-%m-%Y"))
    @invoice.generate_reference
    @companies = client.companies
    @title = 'Новый счет'
    render layout: 'modal'
  end

  def create
    invoice = Invoice.new invoice_params.merge(status: 'черновик')
    # TODO redirect to show page
    if invoice.save
      redirect_to invoice_path(invoice.id), notice: 'Элемент создан успешно'
    else
      redirect_to :back, alert: 'Произошла ошибка'
    end
  end

  def edit
    @invoice = Invoice.client_invoices(client).find params[:id]
    @companies = client.companies
    @title = 'Изменить счет'
    render 'new', layout: 'modal'
  end

  def update
    invoice = Invoice.client_invoices(client).find params[:id]
    renew do
      invoice.update invoice_params
    end
  end

  def show
    @invoices = Invoice.client_invoices(client)
    @invoice = Invoice.includes(:items).client_invoices(client).find params[:id]
    @item = Item.new
  end

  def pdf
    @invoice = Invoice.client_invoices(client).find params[:id]
    pdf = render_to_string pdf: 'file.pdf', template: 'invoices/pdf.html.erb'
    send_data pdf, filename: "#{@invoice.reference_no}.pdf"
  end

  def notice
    invoice = Invoice.client_invoices(client).find params[:id]
    type = params[:type]
    case type
      when 'invoiced'
        if Notifications.notice_invoice(invoice, 'Выставление счета').deliver_now
          notice = 'Письмо отправленно успешно'
          invoice.invoiced!
        end
      when 'remainder'
        if Notifications.notice_invoice(invoice, 'Повторная отправка').deliver_now
          notice = 'Письмо отправленно успешно'
        end

    end
    redirect_to :back, notice: notice
  end


  private

  def invoice_params
    params.require(:invoice).permit(:reference_no, :due_date, :company_id, :tax, :notes)
  end
end
