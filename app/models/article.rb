class Article < ApplicationRecord
  belongs_to :user
  has_many_attached :images
  has_one_attached :ogp_image
  has_many :taggings, as: :taggable
  has_many :tags, through: :taggings

  validates :permalink, uniqueness: { conditions: -> { where(state: :published) } }, if: :published?
  validates :permalink, presence: true, if: :published?

  enum state: { draft: 0, published: 1 }

  def content_html
    require 'html/pipeline'
    require 'commonmarker'

    pipeline = HTML::Pipeline.new [
      HTML::Pipeline::MarkdownFilter,
      HTML::Pipeline::YoutubeFilter,
    ]
    pipeline.call(content)[:output].html_safe
  end
end
