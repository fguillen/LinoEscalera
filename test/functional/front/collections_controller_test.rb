require "test_helper"

class Front::CollectionsControllerTest < ActionController::TestCase
  def test_show
    item_1 = FactoryGirl.create(:item, :collection_list => [Item::COLLECTIONS[:home], Item::COLLECTIONS[:film]], :position => 10)
    item_2 = FactoryGirl.create(:item, :collection_list => [Item::COLLECTIONS[:home], Item::COLLECTIONS[:commercial]], :position => 9)
    item_3 = FactoryGirl.create(:item, :collection_list => [Item::COLLECTIONS[:home], Item::COLLECTIONS[:brand]], :position => 8)

    get :show, :id => Item::COLLECTIONS[:home]
    assert_template "front/collections/show"
    assert_equal([item_3, item_2, item_1].ids, assigns(:items).ids)

    get :show, :id => Item::COLLECTIONS[:commercial]
    assert_equal([item_2].ids, assigns(:items).ids)
  end
end
