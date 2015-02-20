class InvoicesController < ApplicationController
  def index
    @invoices = Invoice.all
  end

  def new
    @invoice = Invoice.new(due_date: Time.now.strftime("%d-%m-%Y"))
    @invoice.generate_reference
    @companies = Company.clients
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
    @invoice = Invoice.find params[:id]
    @companies = Company.clients
    @title = 'Изменить счет'
    render 'new', layout: 'modal'
  end

  def update
    invoice = Invoice.find params[:id]
    renew do
      invoice.update invoice_params
    end
  end

  def show
    @invoices = Invoice.all
    @invoice = Invoice.includes(:items).find params[:id]
    @item = Item.new
  end

  def pdf
    @invoice = Invoice.find params[:id]
    pdf = render_to_string pdf: 'file.pdf', template: 'invoices/pdf.html.erb'
    send_data pdf, filename: "#{@invoice.reference_no}.pdf"
  end


  private

  def invoice_params
    params.require(:invoice).permit(:reference_no, :due_date, :company_id, :tax, :notes)
  end
end
