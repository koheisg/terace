require 'html/pipeline'
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
          HTML::Pipeline::TableOfContentsFilter,
        ], { gfm: true, unsafe: true, sanitization_config: allowlist, scope: 'highlight', anchor_icon: anchor_icon }
      end

      def anchor_icon
        '<i aria-hidden="true" class="fas fa-link"></i>'
      end

      def allowlist
        {
          attributes: {
            'blockquote' => ['class','data-lang'],
            'p' => ['lang', 'dir'],
            'a' => ['href'],
            'span' => ['class'],
            'pre' => ['lang', 'class'],
          }
        }
      end
  end
end
