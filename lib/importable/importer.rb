require 'importable/parser'

module Importable
  class Importer
    def self.drafts_dir
      File.join(ENV['TARGET_DIR'], '_drafts', '**')
    end

    def self.posts_dir
      File.join(ENV['TARGET_DIR'], '_posts', '**')
    end

    def self._import(file, state, site)
      Rails.logger.error file
      parser = Importable::Parser.new(file)
      tags = parser.create_tags(site)
      parser.create_article(tags, state, site)
    end

    def self.import(site)
      Dir.glob(posts_dir).each do |file|
        _import(file, Permalink.states[:shipped], site)
      end

      Dir.glob(drafts_dir).each do |file|
        _import(file, Permalink.states[:draft], site)
      end
    end
  end
end
