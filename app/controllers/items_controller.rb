class ItemsController < ApplicationController
  def new
    @item_templates = ItemTemplate.all
    @title = 'Вставить элемент из шаблона'
    render layout: 'modal'
  end

  def create
    item = if params.has_key?(:item_template)
      attrs = ItemTemplate.attributes_for(params[:item_template])
      Item.new attrs.merge(quantity: params[:quantity], invoice_id: params[:invoice_id])
    else
      Item.new item_params.merge(invoice_id: params[:invoice_id])
    end
    store(invoice_path(params[:invoice_id])) do
      item.save
    end
  end

  def destroy
    item = Item.find params[:id]
    if item.destroy
      redirect_to :back, notice: 'Элемент удален'
    end
  end

  private

  def item_params
    params.require(:item).permit(:name, :description, :cost, :quantity)
  end
end
