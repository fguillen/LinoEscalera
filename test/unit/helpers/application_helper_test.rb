require "test_helper"

class ApplicationHelperTest < ActionView::TestCase
  def test_menu_class
    request_mock = mock
    self.stubs(:request).returns(request_mock)

    request_mock.stubs(:fullpath).returns("/wadus/wadus")
    assert_equal("no-active", menu_class(:film))

    request_mock.stubs(:fullpath).returns("/front/collections/film")
    assert_equal("active", menu_class(:film))

    request_mock.stubs(:fullpath).returns("/front/collections/commercial")
    assert_equal("active", menu_class(:commercial))

    request_mock.stubs(:fullpath).returns("/front/collections/brand")
    assert_equal("active", menu_class(:brand))

    request_mock.stubs(:fullpath).returns("/front/about")
    assert_equal("active", menu_class(:about))
  end

end
