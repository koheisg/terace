class SearchFormBuider < ActionView::Helpers::FormBuilder
  def radio_button(method, tag_value, options = {})
    options[:name] = method if tag_value.present?
    super
  end

  def search_field(attribute, options = {})
    options[:name] = attribute if attribute.present?
    super
  end

  def text_field(attribute, options = {})
    options[:name] = attribute
    super
  end

  def select(attribute, choices, options = {}, html_options = {}, &block)
    html_options[:name] = attribute
    super
  end

  def submit(value = nil, options = {})
    super(value || :search, { name: nil }.merge(options))
  end
end
