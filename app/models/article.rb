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

  def ogp_png
    rsvg = RSVG::Handle.new_from_data(svg)
    surface = Cairo::ImageSurface.new(Cairo::FORMAT_ARGB32, 800, 800)
    context = Cairo::Context.new(surface)
    context.render_rsvg_handle(rsvg)
    b = StringIO.new
    surface.write_to_png(b)
    b.string
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
    HTML::Pipeline::SanitizationFilter::WHITELIST.merge(add_list)
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

  def svg
    <<~SVG
      <?xml version="1.0" encoding="UTF-8"?>
      <svg width="537px" height="69px" viewBox="0 0 537 69" version="1.1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink">
        <!-- Generator: Sketch 52.3 (67297) - http://www.bohemiancoding.com/sketch -->
        <title>Type something</title>
        <desc>Created with Sketch.</desc>
        <g id="Page-1" stroke="none" stroke-width="1" fill="none" fill-rule="evenodd" font-family="HiraginoSans-W3, Hiragino Sans" font-size="69" font-weight="300">
          <text id="Type-something" fill="#000000">
            <tspan x="0" y="54">#{title}</tspan>
          </text>
        </g>
      </svg>
    SVG
  end
end
