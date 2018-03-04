class Article < ApplicationRecord
  belongs_to :user
  has_many_attached :images
  has_one_attached :ogp_image

  enum state: { draft: 0, published: 1 }

  def content_html
    require 'html/pipeline'
    require 'commonmarker'

    filter = HTML::Pipeline::MarkdownFilter.new(content)
    filter.call.html_safe
  end
end
