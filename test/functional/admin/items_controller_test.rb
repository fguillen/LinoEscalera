require "test_helper"

class Admin::ItemsControllerTest < ActionController::TestCase
  def setup
  end

  def test_index
    item_1 = FactoryGirl.create(:item)
    item_2 = FactoryGirl.create(:item)

    get :index

    assert_template "admin/items/index"
    assert_equal([item_2, item_1].ids, assigns(:items).ids)
  end

  def test_index_with_collection
    item_1 = FactoryGirl.create(:item, :collection_list => [Item::COLLECTIONS[:home], Item::COLLECTIONS[:film]], :position => 10)
    item_2 = FactoryGirl.create(:item, :collection_list => [Item::COLLECTIONS[:home], Item::COLLECTIONS[:commercial]], :position => 9)
    item_3 = FactoryGirl.create(:item, :collection_list => [Item::COLLECTIONS[:home], Item::COLLECTIONS[:brand]], :position => 8)

    get :index, :collection => Item::COLLECTIONS[:home]
    assert_equal([item_3, item_2, item_1].ids, assigns(:items).ids)

    get :index, :collection => Item::COLLECTIONS[:commercial]
    assert_equal([item_2].ids, assigns(:items).ids)
  end

  def test_new
    get :new
    assert_template "admin/items/new"
    assert_not_nil(assigns(:item))
  end

  def test_create_invalid
    Item.any_instance.stubs(:valid?).returns(false)

    post :create

    assert_template "new"
    assert_not_nil(flash[:alert])
  end

  def test_create_valid
    post(
      :create,
      :item => {
        :title => "Item Title",
        :text => "My **text**",
        :text_es => "Spanish"
      }
    )

    item = Item.last
    assert_redirected_to edit_admin_item_path(item)

    assert_equal("Item Title", item.title)
    assert_equal("My **text**", item.text)
    assert_equal("Spanish", item.text_es)
  end

  def test_edit
    item = FactoryGirl.create(:item)

    get :edit, :id => item

    assert_template "edit"
    assert_equal(item, assigns(:item))
  end

  def test_update_invalid
    item = FactoryGirl.create(:item)
    Item.any_instance.stubs(:valid?).returns(false)

    put :update, :id => item

    assert_template "edit"
    assert_not_nil(flash[:alert])
  end

  def test_update_valid
    item = FactoryGirl.create(:item)

    put(
      :update,
      :id => item,
      :item => {
        :title => "Other Title"
      }
    )

    item.reload

    assert_redirected_to edit_admin_item_path(item)
    assert_not_nil(flash[:notice])

    assert_equal("Other Title", item.title)
  end

  def test_destroy
    item = FactoryGirl.create(:item)

    delete :destroy, :id => item

    assert_redirected_to :admin_items
    assert_not_nil(flash[:notice])

    assert !Item.exists?(item.id)
  end

  def test_reorder
    Item.destroy_all

    item_1 = FactoryGirl.create(:item, :position => 10)
    item_2 = FactoryGirl.create(:item, :position => 20)
    item_3 = FactoryGirl.create(:item, :position => 30)

    assert_equal([item_1, item_2, item_3].ids, Item.by_position.ids)

    post(
      :reorder,
      :ids => [item_2, item_3, item_1].ids
    )

    assert_response :success
    assert_equal("application/json", response.content_type)
    assert_equal("ok", JSON.parse(response.body)["status"])

    assert_equal([item_2, item_3, item_1].ids, Item.by_position.ids)

    item_1.reload
    item_2.reload
    item_3.reload

    assert_equal(10, item_2.position)
    assert_equal(20, item_3.position)
    assert_equal(30, item_1.position)
  end
end
