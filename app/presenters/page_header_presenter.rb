class PageHeaderPresenter < Presenter
  def render
    markup(:div, class: 'page-header') do |m|
      m.div(class: 'breadcrumb breadcrumb-page') do
        breadcrumbs.each do |bc|
          if bc[2].present?
            m.li do
              m << link_to(fa_icon(bc[0], text: bc[1]), bc[2])
            end
          else
            m.li(class: 'active') do
              m << fa_icon(bc[0], text: bc[1])
            end
          end
        end
        m.li(class: 'active') do
          m << fa_icon(fetch('page_title_icon'), text: fetch('current_page_label') || fetch('page_title_text'))
        end
      end
    end
  end

  private

  def breadcrumbs
    fetch('breadcrumbs') || []
  end
end
