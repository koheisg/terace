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

  before_save :set_published_at, :set_modified_at

  validates :permalink, uniqueness: { conditions: -> { shipped } }, if: :shipped?
  validates :permalink, presence: true, if: :shipped?

  enum state: { draft: 0, shipped: 1 }

  scope :published, -> { shipped.where('articles.published_at <= ?', Time.current) }

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

  def set_published_at
    if published_at.blank? && (changes[:state] == ['draft', 'shipped'] || changes[:state] == [nil, 'shipped'])
      self.published_at = Time.current
    end
  end

  def set_modified_at
    if shipped?
      self.modified_at = Time.current
    end
  end

end
