module ApplicationHelper
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
end
