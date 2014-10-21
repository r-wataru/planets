class MainSidebarPresenter < Presenter
  def render
    markup(:div, class: 'sidebar-nav') do |m|
      m.ul(class: 'nav nav-sidebar') do
        m << dashboard
        m << result
        m << member
      end
    end
  end

  private

  def dashboard
    html_class =
      case action_name
      when 'admin/dashboard#index'
        'active'
      else
        nil
      end

    markup(:li, class: html_class) do |m|
      m << link_to(fa_icon('dashboard', text: 'ダッシュボード'), view_context.root_path)
    end
  end
  
  def result
    html_class = params[:controller] == 'results' ? 'active' : ''
    markup(:li, class: html_class) do |m|
      m << link_to(fa_icon('list', text: '成績表'), view_context.results_path)
    end
  end
  
  def member
    html_class = params[:controller] == '' ? 'active' : ''
    markup(:li, class: html_class) do |m|
      m << link_to(fa_icon('list', text: 'メンバー'), "")
    end
  end
end
