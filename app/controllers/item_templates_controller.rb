class ItemTemplatesController < ApplicationController
  def new
    @title = 'Новый шаблон этапа'
    @item_template = ItemTemplate.new
    render layout: 'modal'
  end

  def create
    item_template = ItemTemplate.new item_template_params.merge!(client: client)
    store do
      item_template.save
    end
    flash[:from] = 'item'
  end

  def edit
    @title = 'Изменить шаблон'
    @item_template = ItemTemplate.for_client(client).find params[:id]
    render 'new', layout: 'modal'
  end

  def update
    item_template = ItemTemplate.for_client(client).find params[:id]
    renew do
      item_template.update item_template_params
    end
    flash[:from] = 'item'
  end

  def destroy
    item_template = ItemTemplate.for_client(client).find params[:id]
    if item_template.destroy
      redirect_to :back, notice: 'Шаблон удален'
    end
    flash[:from] = 'item'
  end

  private

  def item_template_params
    params.require(:item_template).permit(:name, :description, :cost)
  end
end
