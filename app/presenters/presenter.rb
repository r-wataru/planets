class Presenter
  include HtmlBuilder

  attr_reader :view_context
  delegate :link_to, :fa_icon, :params, :truncate, to: :view_context

  def initialize(view_context)
    @view_context = view_context
  end

  private

  # ビューコンテキスト（ERBテンプレート）のインスタンス変数を取得する
  def fetch(variable_name)
    view_context.instance_variable_get(:"@#{variable_name}")
  end

  def action_name
    "#{params[:controller]}##{params[:action]}"
  end
end
