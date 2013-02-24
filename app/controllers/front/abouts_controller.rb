class Front::AboutsController < Front::FrontController
  def show
    @page = Page.where(:title => "About").first
  end
end