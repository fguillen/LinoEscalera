class Admin::AboutsController < Admin::AdminController
  def edit
    @page = Page.where(:title => "About").first
  end

  def update
    @page = Page.where(:title => "About").first
    if @page.update_attributes(params[:page])
      redirect_to edit_admin_about_path, :notice  => "Successfully updated Page."
    else
      flash.now[:alert] = "Some error trying to update Page."
      render :action => "edit"
    end
  end
end
