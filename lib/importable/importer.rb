require 'importable/parser'

module Importable
  class Importer
    def self.drafts_dir
      File.join(ENV['TARGET_DIR'], '_drafts', '**')
    end

    def self.posts_dir
      File.join(ENV['TARGET_DIR'], '_posts', '**')
    end

    def self._import(file, state, user_id)
      Rails.logger.error file
      p = Importable::Parser.new(file)
      tags = p.create_tags
      p.create_article(tags, state, user_id)
    end

    def self.import
      Dir.glob(posts_dir).each do |file|
        _import(file, Article.states[:published], 1)
      end

      Dir.glob(drafts_dir).each do |file|
        _import(file, Article.states[:draft], 1)
      end
    end
  end
end
