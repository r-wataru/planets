class NavbarPresenter < Presenter
  delegate :current_user, to: :view_context

  def render
    markup(:div, class: 'navbar navbar-inverse navbar-fixed-top', role: 'navigation') do |m|
      m.div(class: 'container-fluid') do
        m << navbar_header
        m.div(class: 'navbar-collapse collapse') do
          #
        end
      end
    end
  end

  private

  def navbar_header
    markup(:div, class: 'navbar-header') do |m|
      m.a(id: 'main-menu-toggle') do
        m << fa_icon('caret-left')
        m << ' '
        m << fa_icon('bars')
        m << ' '
        m << fa_icon('caret-right')
      end
      m << link_to('Planets', :root, class: 'navbar-brand')
    end
  end
end
