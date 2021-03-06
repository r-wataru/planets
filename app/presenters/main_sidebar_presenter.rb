class MainSidebarPresenter < Presenter
  delegate :current_user, :current_admin, to: :view_context

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
        if current_user
          m << inquiry
          m << power_off
        else
          m << power
        end
        if current_admin
          m << admin
        end
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
      if current_user
        m << link_to(fa_icon('user', text: truncate(current_user.display_name, length: 12, omission: "...")), view_context.user_path(current_user))
      else
        m << link_to(fa_icon('dashboard', text: "トップ"), view_context.root_path)
      end
    end
  end

  def power
    markup(:li, class: '') do |m|
      m << link_to(fa_icon('power-off', text: 'ログイン'), view_context.new_session_path)
    end
  end

  def power_off
    markup(:li, class: '') do |m|
      m << link_to(fa_icon('power-off', text: 'ログアウト'), view_context.session_path,
        method: :delete, data: { confirm: "Are You Sure?" })
    end
  end

  def result
    html_class = (params[:controller] == 'results' || params[:controller] == 'games' || params[:controller] == "pitchers") ? 'active' : ''
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
    html_class = (params[:controller] == 'schedules' || params[:controller] == "plan_details") ? 'active' : ''
    markup(:li, class: html_class) do |m|
      m << link_to(fa_icon('table', text: 'スケジュール'), view_context.schedules_path)
    end
  end

  def blog
    html_class = (params[:controller] == 'posts' or params[:controller] == 'comments') ? 'active' : ''
    markup(:li, class: html_class) do |m|
      m << link_to(fa_icon('book', text: '掲示板'), view_context.posts_path)
    end
  end

  def vote
    html_class = params[:controller] == 'votes' ? 'active' : ''
    markup(:li, class: html_class) do |m|
      m << link_to(fa_icon('bullhorn', text: '投票'), view_context.votes_path)
    end
  end

  def attendance
    html_class = params[:action] == 'still' ? 'active' : ''
    markup(:li, class: html_class) do |m|
      m << link_to(fa_icon('send', text: '出席表'), view_context.still_schedules_path)
    end
  end

  def admin
    html_class = params[:controller] == 'administrators' ? 'active' : ''
    markup(:li, class: html_class) do |m|
      m << link_to(fa_icon('unlock', text: '代理ログイン'), view_context.administrators_path)
    end
  end

  def inquiry
    html_class = params[:controller] == 'inquries' ? 'active' : ''
    markup(:li, class: html_class) do |m|
      m << link_to(fa_icon('question-circle', text: '問い合わせ一覧'), view_context.inquiries_path)
    end
  end
end
