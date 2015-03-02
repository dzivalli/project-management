class ItemsController < ApplicationController
  def new
    @item_templates = ItemTemplate.for_client(client)
    @title = 'Вставить элемент из шаблона'
    render layout: 'modal'
  end

  def create
    item = if params.has_key?(:item_template)
      # TODO check if template id belongs to client templates scope, same for all templates
      attrs = ItemTemplate.attributes_for(params[:item_template])
      Item.new attrs.merge(quantity: params[:quantity], invoice_id: params[:invoice_id])
    else
      Item.new item_params.merge(invoice_id: params[:invoice_id])
    end
    store(invoice_path(params[:invoice_id])) do
      item.save if client_invoice?
    end
  end

  def destroy
    item = Item.find params[:id]
    if client_invoice? && item.destroy
      redirect_to :back, notice: 'Элемент удален'
    end
  end

  private

  def client_invoice?
    Invoice.client_invoices(client).ids.include?(params[:invoice_id].to_i)
  end

  def item_params
    params.require(:item).permit(:name, :description, :cost, :quantity)
  end
end
