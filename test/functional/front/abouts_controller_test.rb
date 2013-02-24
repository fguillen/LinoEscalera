require "test_helper"

class Front::AboutsControllerTest < ActionController::TestCase
  def test_show
    page = FactoryGirl.create(:page, :title => "About")

    get :show

    assert :success
    assert_template "front/about"
    assert_equal(page, assigns(:page))
  end
end
