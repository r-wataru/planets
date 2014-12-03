class HorizontalFormPresenter
  include HtmlBuilder

  attr_reader :form_builder, :view_context
  delegate :label, :text_field, :password_field, :check_box, :radio_button,
    :email_field, :number_field, :password_field, :text_area, :hidden_field,
    :date_select, :file_field, :object, :select, to: :form_builder
  delegate :link_to, :image_tag, to: :view_context

  def initialize(form_builder, view_context, default_label_columns = 2)
    @form_builder = form_builder
    @view_context = view_context
    @default_label_columns = default_label_columns
    @maximum_columns = 1
  end

  def text_field_block(name, label_text, options = {})
    html_options = {}
    html_options[:class] = 'form-control'
    html_options[:class] += " #{options[:class]}" if options[:class].present?
    html_options[:autofocus] = options[:autofocus] if options[:autofocus]
    html_options[:required] = options[:required] if options[:required]
    html_options[:placeholder] = options[:placeholder] || label_text
    [ :autofocus, :disabled, :max, :maxlength, :min, :pattern, :readonly, :required, :step ].each do |attr|
      html_options[attr] = options[attr] if options[attr]
    end
    html_options[:value] = options[:value] if options[:value]

    if options[:new_user]
      input_columns = 12
    else
      input_columns = calculate_columns(options)
    end
    
    class_name = options[:type] == "hidden" ? "" : "form-group"
    type = options[:type] || 'text'

    markup(:div, class: class_name) do |m|
      m << decorated_label(name, label_text, options) unless type == "hidden"
      m.div(class: "col-sm-#{input_columns}") do
        m << send("#{type}_field", name, html_options)
        m << error_messages_for(name)
      end
    end
  end

  def number_field_block(name, label_text, options = {})
    text_field_block(name, label_text, options.merge(type: 'number'))
  end

  def hidden_field_block(name, label_text, options = {})
    text_field_block(name, label_text, options.merge(type: 'hidden'))
  end

  def email_field_block(name, label_text, options = {})
    text_field_block(name, label_text, options.merge(type: 'email'))
  end

  def password_field_block(name, label_text, options = {})
    text_field_block(name, label_text, options.merge(type: 'password'))
  end

  def date_select_block(name, label_text, options = {})
    html_options = {}
    html_options[:class] = 'form-control date-select'
    html_options[:class] += " #{options[:class]}" if options[:class].present?
    [ :disabled, :max, :maxlength, :min, :pattern, :readonly, :required, :step ].each do |attr|
      html_options[attr] = options[attr] if options[attr]
    end
    select_options = {}
    select_options[:start_year] = 1940
    select_options[:end_year] = Time.now.year
    if options[:new_user]
      input_columns = 12
    else
      input_columns = calculate_columns(options)
    end

    markup(:div, class: 'form-group') do |m|
      m << decorated_label(name, label_text, options)
      m.div(class: "col-sm-#{input_columns}") do
        m << date_select(name, select_options, html_options)
        m << error_messages_for(name)
      end
    end
  end

  def file_block(name, label_text, path, alt, options = {})
    html_options = {}
    html_options[:title] = "Search for a file to add"
    input_columns = calculate_columns(options)

    markup(:div, class: 'form-group') do |m|
      m << decorated_label(name, label_text, options)
      m.div(class: "col-sm-#{input_columns}") do
        if object.errors.empty? && path.present?
          m << image_tag(path, alt: alt, width: "100px")
          m << check_box("#{name}_destroy", html_options)
          m << checkbox_label("#{name}_destroy", "削除", options)
        end
        m << file_field(name, html_options)
        m << error_messages_for(name)
      end
    end
  end

  def table_form_block(names, label_texts, num_values, objects, options)
    main_options = {}
    main_options[:include_blank] = options[:include_blank] || false
    main_options[:prompt] = ''

    html_options = {}
    html_options[:class] = 'form-control'
    html_options[:class] += " #{options[:class]}" if options[:class].present?
    html_options[:required] = options[:required]

    html_options2 = {}
    html_options2[:class] = "form-control name_#{options[:data]}_selecter"
    html_options2[:class] += " #{options[:class]}" if options[:class].present?
    html_options2[:required] = options[:required]

    helper_options = {}
    helper_options[:class] = "form-control helper_#{options[:data]}_form_field"
    helper_options[:class] += " #{options[:class]}" if options[:class].present?
    helper_options[:required] = false
    helper_options[:placeholder] = "助っ人名"

    choices = objects.map { |o| [ o.send(:display_user_name), o.id ] }
    choices = choices << [ "助っ人", 0 ]

    markup(:div) do |m|
      m.div(class: "table-responsive", style: "overflow: scroll") do
        m.table(class: "table table-hover table-striped") do
          m.tr(class: "statsTable01") do
            label_texts.each do |label|
              m.th(label)
            end
            m.tr do
              names.each_with_index do |name, i|
                m.td do
                  if i == 0
                    m << select(name, choices, main_options, html_options2)
                    m << send("text_field", :helper_member, helper_options)
                  else
                    m << select(name, num_values, main_options, html_options)
                  end
                end
              end
            end
          end
        end
      end
      names.each do |key|
        m << error_messages_for(key)
      end
    end
  end

  def table_score_form_block(name, label_text, keys_array, num_values, error_values, feilds, options)
    main_options = {}
    main_options[:include_blank] = false

    html_options = {}
    html_options[:class] = 'form-control'
    html_options[:class] += " #{options[:class]}" if options[:class].present?
    html_options[:required] = options[:required]

    select_options = {}
    select_options[:class] = 'form-control'
    select_options[:class] += " #{options[:class]}" if options[:class].present?
    select_options[:required] = false

    input_columns = calculate_columns(options)

    markup(:div, class: 'form-group') do |m|
      m << decorated_label(name, label_text, options)
      m.div(class: "col-sm-#{input_columns}") do
        m.div(class: "table-responsive", style: "overflow: scroll;") do
          m.table(class: "table table-hover table-striped") do
            m.tr(class: "statsTable01") do
              m.td("チーム名")
              (1..9).each do |n|
                m.td(n)
              end
              m.td("T")
            end
            keys_array.each_with_index do |keys, i|
              m.tr do
                keys.each_with_index do |key, n|
                  m.td do
                    if n == 0
                      html_options[:placeholder] = feilds[i]
                      m << send("text_field", key, html_options)
                    else
                      m << select(key, num_values, main_options, select_options)
                    end
                  end
                end
              end
            end
          end
        end
        error_values.each do |key|
          m << error_messages_for(key)
        end
      end
    end
  end

  def radio_box_block(name, label_text, hash, options = {})
    input_columns = calculate_columns(options)

    markup(:div, class: 'form-group') do |m|
       m << decorated_label(name, label_text, options)
       m.div(class: "col-sm-#{input_columns} radio-box") do
         hash.each do |h|
            m << label("#{name}_#{h[:value]}", h[:key], {} )
            m << radio_button(name, h[:value])
         end
         m << error_messages_for(name)
       end
    end
  end

  def text_area_block(name, label_text, options = {})
    html_options = {}
    html_options[:class] = 'form-control'
    input_columns = calculate_columns(options)

    markup(:div, class: "form-group") do |m|
      m << decorated_label(name, label_text, options)
      m.div(class: "col-sm-#{input_columns} radio-box") do
        m << text_area(name, html_options)
      end
    end
  end

  def select_box(name, label_text, objects, method_name, options = {})
    main_options = {}
    main_options[:include_blank] = options[:include_blank] || false
    main_options[:prompt] = options[:prompt] || false
    html_options = {}
    html_options[:class] = 'form-control normal-select'
    html_options[:class] += " #{options[:class]}" if options[:class].present?
    html_options[:required] = options[:required]
    html_options[:placeholder] = options[:placeholder] || label_text
    choices = objects.map { |o| [ o.send(method_name), o.id ] }
    if options[:add_select].present?
      choices << options[:add_select]
    end

    if options[:new_user]
      input_columns = 12
    else
      input_columns = calculate_columns(options)
    end

    markup(:div, class: 'form-group') do |m|
      if options[:new_user]
        m.div(label_text, class: "col-sm-#{input_columns}")
      else
        m << decorated_label(name, label_text, options)
      end
      m.div(class: "col-sm-#{input_columns}") do
        m << select(name, choices, main_options, html_options)
        m << error_messages_for(name)
      end
    end
  end

  def delete_and_submit_button(path, options = {})
    label_text = options[:label_text1] || '更新'
    type = options[:type1] || 'primary'
    columns = options[:columns] || @maximum_columns

    columns_num = columns == 12 ? 0 : 2

    markup(:div, class: 'form-group') do |m|
      m.div(class: "col-sm-#{columns_num}")
      m.div(class: "col-sm-#{columns - columns_num}") do
        m.button(label_text, type: 'submit', class: "btn btn-#{type}")
        m << link_to("削除", path, class: "btn btn-danger", method: :delete, data: { confirm: "Are You Sure?"})
      end
    end
  end

  def submit_button(options = {})
    label_text1 = options[:label_text1] || '追加'
    label_text2 = options[:label_text2] || '更新'
    type1 = options[:type1] || 'primary'
    type2 = options[:type2] || 'primary'
    columns = options[:columns] || @maximum_columns

    label_text = object.persisted? ? label_text2 : label_text1
    type = object.persisted? ? type2 : type1
    label_text = options[:label_text] ? options[:label_text] : label_text
    data = options[:confirm] == true ? 'return confirm("Are You Sure?");' : nil

    columns_num = columns == 12 ? 0 : 2

    markup(:div, class: 'form-group') do |m|
      m.div(class: "col-sm-12") do
        m.button(label_text, type: 'submit', class: "btn btn-#{type}",  onclick: data)
      end
    end
  end

  def error_messages_for(name)
    return '' if object.errors.empty?
    markup do |m|
      object.errors.full_messages_for(name).each do |message|
        m.ul(class: 'error-message') do |m|
          m.li do |m|
            m.text message
          end
        end
      end
    end
  end

  private
  def decorated_label(name, label_text, options = {})
    label_columns = options[:label_columns] || @default_label_columns
    if options[:new_user]
      html_class = "col-sm-12 control-label"
    else
      html_class = "col-sm-#{label_columns} control-label"
    end
    html_class << ' required' if options[:required]
    label(name, label_text, class: html_class)
  end

  def checkbox_label(name, label_text, options = {})
    html_class = "control-label"
    html_class << ' required' if options[:required]
    label(name, label_text, class: html_class)
  end

  def calculate_columns(options)
    label_columns = options[:label_columns] || @default_label_columns
    input_columns = options[:columns] || (12 - label_columns)
    if label_columns + input_columns > @maximum_columns
      @maximum_columns = label_columns + input_columns
    end
    input_columns
  end
end
