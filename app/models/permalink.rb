class Permalink < ApplicationRecord
  belongs_to :permalinkable, polymorphic: true
  belongs_to :site

  enum state: { draft: 0, shipped: 1 }
  scope :published, -> { shipped.where('permalinks.published_at <= ?', Time.current) }
  scope :match_if, -> (params) { where(params) if params.values.first }
  scope :contains, -> (params) { where("permalinks.#{params.keys.first} LIKE ?", "%#{sanitize_sql_like(params.values.first)}%") if params.values.first.present? }
  scope :article_types, -> { where(permalinkable_type: 'Article') }

  before_save :set_published_at, :set_modified_at

  validates :state, presence: true
  validates :path, uniqueness: { conditions: -> { shipped } }, if: :shipped?

  def build_permalinkable
    if permalinkable_type == 'Article'
      self.permalinkable = Article.new
    elsif permalinkable_type == 'Page'
      self.permalinkable = Page.new
    end
  end

  private
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
