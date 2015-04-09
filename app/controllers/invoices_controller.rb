class InvoicesController < ApplicationController
  def index
    @invoices = Invoice.client_invoices(client)
  end

  def new
    @invoice = Invoice.new(due_date: Time.now.strftime("%d-%m-%Y"))
    @invoice.generate_reference!
    @companies = Company.customer_companies(client)
    @selected = params[:company_id] if params.key?(:company_id)
    @title = 'Новый счет'
    render layout: 'modal'
  end

  def create
    invoice = if params.key?(:project)
                Invoice.from_project(params)
              else
                Invoice.new invoice_params.merge(status: 'черновик')
              end
    if invoice.save
      redirect_to invoice_path(invoice), notice: 'Элемент создан успешно'
    else
      redirect_to :back, alert: 'Произошла ошибка'
    end
  end

  def edit
    @invoice = Invoice.client_invoices(client).find params[:id]
    @companies = Company.customer_companies(client)
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

  def destroy
    invoice = Invoice.client_invoices(client).find params[:id]
    if invoice.destroy
      redirect_to invoices_path, notice: 'Счет успешно удален'
    end
  end

  def pdf
    @invoice = Invoice.includes(:company).client_invoices(client).find params[:id]
    @main_company = client.main_company
    pdf = render_to_string pdf: 'file.pdf', template: 'invoices/pdf.html.haml'
    send_data pdf, filename: "#{@invoice.reference_no}.pdf"
  end

  def notice
    invoice = Invoice.client_invoices(client).find params[:id]
    notice = invoice.send_email!(params[:type])
    redirect_to :back, notice: notice
  end

  def pay
    @title = 'Оплата счета с помощью Робокассы'
    invoice = Invoice.client_invoices(client).find params[:id]
    @pay_desc = invoice.pay_hash
    render layout: 'modal'
  end

  private

  def invoice_params
    params.require(:invoice).permit(:reference_no, :due_date, :company_id, :notes)
  end
end
