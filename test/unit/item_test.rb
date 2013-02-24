require "test_helper"

class ItemTest < ActiveSupport::TestCase
  def test_should_be_valid
    assert FactoryGirl.create(:item).valid?
  end

  def test_on_create_initialize_position
    item_1 = FactoryGirl.create(:item, :position => 10)
    item_2 = FactoryGirl.create(:item)

    assert_equal(9, item_2.position)
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
end
