class Article < ApplicationRecord
  belongs_to :user

  enum state: { draft: 0, published: 1 }

  def content_html
    require 'html/pipeline'
    require 'commonmarker'

    filter = HTML::Pipeline::MarkdownFilter.new(content)
    filter.call.html_safe
  end
end
