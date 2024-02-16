require 'html/pipeline'
require 'html/pipeline/h1_to_h2_filter'
require 'commonmarker'

module Htmlable
  extend ActiveSupport::Concern

  TRUNCATED_COUNT = 800

  included do
    def content_html
      result = pipeline.call(content)
      result[:output].to_s.html_safe
    end

    def content_truncated?
      content.length > TRUNCATED_COUNT
    end

    def content_truncated_html
      result = pipeline.call(content.truncate(TRUNCATED_COUNT, separator: /\n/))
      result[:output].to_s.html_safe
    end

    private

      def pipeline
        HTML::Pipeline.new [
          HTML::Pipeline::MarkdownFilter,
          HTML::Pipeline::SyntaxHighlightFilter,
          HTML::Pipeline::SanitizationFilter,
          HTML::Pipeline::H1ToH2Filter,
        ], { gfm: true, unsafe: true, allowlist: allowlist, scope: 'highlight' }
      end

      def allowlist
        HTML::Pipeline::SanitizationFilter::ALLOWLIST.merge(
          {
            attributes: {
              'img' => ['src', 'alt', 'width', 'height'],
              'blockquote' => ['class','data-lang'],
              'p' => ['lang', 'dir'],
              'a' => ['href'],
              'span' => ['class'],
              'pre' => ['lang', 'class'],
            }
          }
        )
      end
  end
end
