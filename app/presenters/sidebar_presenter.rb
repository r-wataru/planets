class SidebarPresenter < Presenter
  def render
    MainSidebarPresenter.new(view_context).render
  end
end
