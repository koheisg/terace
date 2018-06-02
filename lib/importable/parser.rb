require 'front_matter_parser'

module Importable
  class Parser
    def initialize(file)
      @file = file
      @parsed = ::FrontMatterParser::Parser.parse_file(@file)
    end

    attr_reader :parsed

    def create_article(tags, state, user_id)
      Article.create!(content: parsed.content,
                     user_id: user_id,
                     state: state,
                     title: parsed.front_matter['title'],
                     permalink: _permalink,
                     created_at: _created_at,
                     updated_at: _updated_at,
                     tags: tags || [])
    end

    def _permalink
      tmp = parsed.front_matter['blogger_orig_url']&.gsub('http://koheisg.dreamin.cc/', '') || File.basename(@file, '.md').gsub('-', '/') + ".html"
      p tmp
      tmp
    end

    def _created_at
      Time.zone.parse(parsed.front_matter['date']) if parsed.front_matter['date']
    end

    def _updated_at
      Time.zone.parse(parsed.front_matter['modified_time']) if parsed.front_matter['modified_time']
    end

    def create_tags
      parsed.front_matter['tags']&.map { |tag| ::Tag.find_or_create_by!(name: tag) } if parsed.front_matter['tags'].present?
    end
  end
end
