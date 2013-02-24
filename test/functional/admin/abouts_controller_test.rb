require "test_helper"

class Admin::AboutsControllerTest < ActionController::TestCase
  def setup
    @page = FactoryGirl.create(:page, :title => "About")
  end

  def test_edit
    get :edit

    assert_template "edit"
    assert_equal(@page, assigns(:page))
  end

  def test_update_invalid
    Page.any_instance.stubs(:valid?).returns(false)

    put :update

    assert_template "edit"
    assert_not_nil(flash[:alert])
  end

  def test_update_valid
    put(
      :update,
      :page => {
        :text => "Other Text",
        :text_es => "Other Text es"
      }
    )

    @page.reload

    assert_redirected_to edit_admin_about_path
    assert_not_nil(flash[:notice])

    assert_equal("Other Text", @page.text)
    assert_equal("Other Text es", @page.text_es)
  end
end
