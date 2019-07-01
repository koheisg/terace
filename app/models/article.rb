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
    result = pipeline.call(content.html_safe)
    result[:output].to_s.html_safe
  end

  private

  def pipeline
    HTML::Pipeline.new [
      HTML::Pipeline::MarkdownFilter,
      HTML::Pipeline::SanitizationFilter,
      HTML::Pipeline::SyntaxHighlightFilter,
    ]
  end
end
