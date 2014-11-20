class MainSidebarPresenter < Presenter
  def render
    markup(:div, class: 'sidebar-nav') do |m|
      m.ul(class: 'nav nav-sidebar') do
        m << dashboard
        m << result
        m << member
        m << schedule
        m << blog
        m << vote
        m << attendance
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
      m << link_to(fa_icon('line-chart', text: '成績表'), view_context.results_path)
    end
  end

  def member
    html_class = params[:controller] == 'users' ? 'active' : ''
    markup(:li, class: html_class) do |m|
      m << link_to(fa_icon('list', text: 'メンバー'), view_context.users_path)
    end
  end

  def schedule
    #html_class = params[:controller] == 'schedules' ? 'active' : ''
    markup(:li, class: "disabled not_yet") do |m|
      m << link_to(fa_icon('table', text: 'スケジュール'), "")
    end
  end

  def blog
    #html_class = params[:controller] == 'schedules' ? 'active' : ''
    markup(:li, class: "disabled not_yet") do |m|
      m << link_to(fa_icon('book', text: 'ブログ'), "")
    end
  end

  def vote
    #html_class = params[:controller] == 'schedules' ? 'active' : ''
    markup(:li, class: "disabled not_yet") do |m|
      m << link_to(fa_icon('bullhorn', text: '投票'), "")
    end
  end

  def attendance
    #html_class = params[:controller] == 'schedules' ? 'active' : ''
    markup(:li, class: "disabled not_yet") do |m|
      m << link_to(fa_icon('send', text: '出席表'), "")
    end
  end
end
