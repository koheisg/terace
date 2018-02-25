class Article < ApplicationRecord
  belongs_to :user

  def content_html
    require 'html/pipeline'
    require 'commonmarker'

    filter = HTML::Pipeline::MarkdownFilter.new(content)
    filter.call.html_safe
  end
end
