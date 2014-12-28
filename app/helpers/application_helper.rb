module ApplicationHelper
  include HtmlBuilder

  def flash_messages
    markup do |m|
      m.div(flash[:alert], class: 'alert alert-danger', role: 'alert') if flash[:alert].present?
      m.div(flash[:notice], class: 'alert alert-info', role: 'alert') if flash[:notice].present?
    end
  end

  def display_position(range)
    case range
    when ["one", true]
      "投手"
    when ["two", true]
      "捕手"
    when ["three", true]
      "一塁"
    when ["four", true]
      "二塁"
    when ["five", true]
      "三塁"
    when ["six", true]
      "遊撃手"
    when ["seven", true]
      "外野手"
    else
    end
  end

  def color_position(range)
    case range
    when ["one", true]
      "success"
    when ["two", true]
      "success"
    when ["three", true]
      "info"
    when ["four", true]
      "info"
    when ["five", true]
      "info"
    when ["six", true]
      "info"
    when ["seven", true]
      "warning"
    else
    end
  end
end
