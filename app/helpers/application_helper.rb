module ApplicationHelper
  include HtmlBuilder

  def format_error_message(model, field, form)
    messages = model.errors[field]
    messages = [ messages ].flatten
    text = raw('')
    messages.each do |message|
      text << content_tag(:p,
        translate_field_name(form, field) + ' ' + message,
        style: "color: red;")
    end
    text
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
