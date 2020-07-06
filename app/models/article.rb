require 'html/pipeline'
require 'commonmarker'

class Article < ApplicationRecord
  include Auditable, Permalinkable

  has_many_attached :images
  has_one_attached :ogp_image
  has_many :taggings, as: :taggable
  has_many :tags, through: :taggings

  def content_html
    result = pipeline.call(content)
    result[:output].to_s.html_safe
  end

  private

  def pipeline
    HTML::Pipeline.new [
      HTML::Pipeline::MarkdownFilter,
      HTML::Pipeline::SyntaxHighlightFilter,
      HTML::Pipeline::SanitizationFilter,
      HTML::Pipeline::TableOfContentsFilter,
    ], { gfm: true, unsafe: true, whitelist: whitelist, scope: 'highlight', anchor_icon: anchor_icon }
  end

  def anchor_icon
    '<i aria-hidden="true" class="fas fa-link"></i>'
  end

  def whitelist
    add_list = {
      attributes: {
        'blockquote' => ['class','data-lang'],
        'p' => ['lang', 'dir'],
        'a' => ['href'],
        'span' => ['class'],
        'pre' => ['lang', 'class'],
      }
    }
    HTML::Pipeline::SanitizationFilter::WHITELIST.deep_merge(add_list)
  end

end
