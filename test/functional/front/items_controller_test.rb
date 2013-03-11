require "test_helper"

class Front::ItemsControllerTest < ActionController::TestCase
  def test_show
    item = FactoryGirl.create(:item)

    get :show, :id => item

    assert :success
    assert_template "front/items/show"
    assert_equal(item, assigns(:item))
  end

  def test_show_not_showing_video_if_not_video_active
    item = FactoryGirl.create(:item, :video => File.open(fixture("pic.jpg")))
    get :show, :id => item
    assert_match(/class="video_qt/, @response.body)

    item.update_attributes(:video_active => false)
    get :show, :id => item
    assert_not_match(/class="video_qt/, @response.body)
  end

  def test_show_not_showing_video_script_if_not_video_script_active
    item = FactoryGirl.create(:item, :video_script => "video_script")
    get :show, :id => item
    assert_match(/class="video_script/, @response.body)

    item.update_attributes(:video_script_active => false)
    get :show, :id => item
    assert_not_match(/class="video_script/, @response.body)
  end

  def test_show_html5_active
    item = FactoryGirl.create(:item, :video => File.open(fixture("pic.jpg")))
    get :show, :id => item
    assert_not_match(/<embed/, @response.body)


    item.update_attributes(:html5_active => false)
    get :show, :id => item
    assert_match(/<embed/, @response.body)
  end
end
