require 'front_matter_parser'

module Importable
  class Parser
    def initialize(file)
      @file = file
      @parsed = ::FrontMatterParser::Parser.parse_file(@file)
    end

    attr_reader :parsed

    def create_article(tags, state, site)
      article = Article.new(
        content: parsed.content,
        created_at: _created_at,
        updated_at: _updated_at,
      )
      Permalink.create!(
        site: site,
        state: state,
        title: parsed.front_matter['title'],
        path: _permalink(state),
        created_at: _created_at,
        updated_at: _updated_at,
        permalinkable: article,
        tags: tags || []
      )
    end

    def _permalink(state)
      unless state == 1
        return ''
      end
      tmp = parsed.front_matter['blogger_orig_url']&.gsub('http://koheisg.dreamin.cc/', '') || __permalink
      tmp
    end

    def __permalink
      a = File.basename(@file, '.md').split('-')
      [a[0..1].join('/'), a[3..-1].join('-')].join('/') + '.html'
    end

    def _created_at
      Time.zone.parse(parsed.front_matter['date']) if parsed.front_matter['date']
    end

    def _updated_at
      Time.zone.parse(parsed.front_matter['modified_time']) if parsed.front_matter['modified_time']
    end

    def create_tags(site)
      parsed.front_matter['tags']&.map { |tag| site.tags.find_or_create_by!(name: tag) } if parsed.front_matter['tags'].present?
    end
  end
end
