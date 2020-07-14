class Permalink < ApplicationRecord
  include Auditable, Taggable

  belongs_to :permalinkable, polymorphic: true
  belongs_to :site
  belongs_to :category, optional: true, counter_cache: true

  accepts_nested_attributes_for :permalinkable

  enum state: { draft: 0, shipped: 1 }
  scope :published, -> { shipped.where('permalinks.published_at <= ?', Time.current) }
  scope :match_if, -> (params) { where(params) if params.values.first.present? }
  scope :match_if_tag_ids, -> (tag_ids) { where(tags: {id: tag_ids}) if tag_ids&.select(&:present?).present? }
  scope :contains, -> (params) { where("permalinks.#{params.keys.first} LIKE ?", "%#{sanitize_sql_like(params.values.first)}%") if params.values.first.present? }
  scope :article_types, -> { where(permalinkable_type: 'Article') }

  before_save :set_published_at, :set_modified_at
  around_update :destroy_permalinkable_was

  validates :state, presence: true
  validates :path, uniqueness: { scope: :site_id, conditions: -> { shipped } }, if: :shipped?

  delegate :name, to: :category, prefix: true, allow_nil: true

  def self.permalinkable_types
    { article: 'Article',
      page: 'Page',
      archive: 'Archive' }
  end

  self.permalinkable_types.keys.each do |key|
    define_method(key) do
      return permalinkable if permalinkable_type == key.to_s.camelize

      key.to_s.camelize.constantize.new
    end
  end

  def build_permalinkable(params = {})
    self.permalinkable = permalinkable_type.constantize.new(params)
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

    def destroy_permalinkable_was
      if changed_attributes.include?(:permalinkable_type)
        permalinkable_was = permalinkable_type_was.constantize.find(permalinkable_id_was)
      end

      yield
      permalinkable_was&.destroy
    end
end
