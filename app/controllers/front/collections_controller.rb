class Front::CollectionsController < Front::FrontController
  def show
    collection = params[:id]  #|| Item::COLLECTIONS[:home]
    @items = Item.tagged_with(collection).by_position
  end
end
