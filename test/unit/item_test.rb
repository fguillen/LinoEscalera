require "test_helper"

class ItemTest < ActiveSupport::TestCase
  def test_should_be_valid
    assert FactoryGirl.create(:item).valid?
  end

  def test_on_create_initialize_position
    item_1 = FactoryGirl.create(:item, :position => 10)
    item_2 = FactoryGirl.create(:item)

    assert_equal(11, item_2.position)
  end

  def test_scope_by_position
    item_1 = FactoryGirl.create(:item, :position => 10)
    item_2 = FactoryGirl.create(:item, :position => 9)

    assert_equal([item_2, item_1].ids, Item.by_position.ids)
  end

  def test_video
    item = FactoryGirl.create(:item, :id => 1001, :video => File.open(fixture("pic.jpg")))
    assert_match(/\/assets\/uploads\/test\/1001\/video.jpg/, item.video.url)
  end

  def test_first_in_collection
    Item.destroy_all

    item_1 = FactoryGirl.create(:item, :position => 20, :collection_list => [Item::COLLECTIONS[:home]])
    item_2 = FactoryGirl.create(:item, :position => 10, :collection_list => [Item::COLLECTIONS[:home]])
    item_3 = FactoryGirl.create(:item, :position => 30, :collection_list => [Item::COLLECTIONS[:home], Item::COLLECTIONS[:film]])

    assert_equal(false, item_1.first_in_collection?)
    assert_equal(true, item_2.first_in_collection?)
    assert_equal(true, item_3.first_in_collection?)
  end

  def test_remove_video_on_demand
    item = FactoryGirl.create(:item, :id => 1001, :video => File.open(fixture("pic.jpg")))

    item.update_attributes(:remove_video => "0")
    assert_equal(true, item.video.exists?)

    item.update_attributes(:remove_video => "1")
    assert_equal(false, item.video.exists?)
  end
end
