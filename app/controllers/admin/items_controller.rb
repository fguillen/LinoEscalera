class Admin::ItemsController < Admin::AdminController
  def index
    @items = Item.by_position
    @items = @items.tagged_with(params[:collection]) if params[:collection]
  end

  def show
    @item = Item.find(params[:id])
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(params[:item])
    if @item.save
      redirect_to edit_admin_item_path(@item), :notice => "Successfully created Item."
    else
      flash.now[:alert] = "Some error trying to create item."
      render :action => "new"
    end
  end

  def edit
    @item = Item.find(params[:id])
  end

  def update
    @item = Item.find(params[:id])
    if @item.update_attributes(params[:item])
      redirect_to edit_admin_item_path(@item), :notice  => "Successfully updated Item."
    else
      flash.now[:alert] = "Some error trying to update Item."
      render :action => 'edit'
    end
  end

  def destroy
    @item = Item.find(params[:id])
    @item.destroy
    redirect_to :admin_items, :notice => "Successfully destroyed Item."
  end

  def reorder
    old_positions = Item.find(params[:ids]).map(&:position).sort

    params[:ids].each_with_index do |id, index|
      Item.update_all(["position=?", old_positions[index]], ["id=?", id])
    end

    render :json => { "status" => "ok" }
  end
end
