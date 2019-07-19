require 'html/pipeline'
require 'commonmarker'

class Article < ApplicationRecord
  include Auditable
  belongs_to :user
  belongs_to :site
  has_many_attached :images
  has_one_attached :ogp_image
  has_many :taggings, as: :taggable
  has_many :tags, through: :taggings

  validates :permalink, uniqueness: { conditions: -> { where(state: :published) } }, if: :published?
  validates :permalink, presence: true, if: :published?

  enum state: { draft: 0, published: 1 }

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
    ], { gfm: true, unsafe: true, whitelist: whitelist}
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
    HTML::Pipeline::SanitizationFilter::WHITELIST.merge(add_list)
  end
end
