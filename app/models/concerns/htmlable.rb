require 'html/pipeline'
require 'commonmarker'

# TODO decorator logicなので、theme側に切り出す
module Htmlable
  extend ActiveSupport::Concern

  included do
    def content_html
      result = pipeline.call(content)
      result[:output].to_s.html_safe
    end

    def content_concated_html
      result = pipeline.call(content.truncate(1000, separator: /\n/))
      result[:output].to_s.html_safe
    end

    private

      def pipeline
        HTML::Pipeline.new [
          HTML::Pipeline::MarkdownFilter,
          HTML::Pipeline::SyntaxHighlightFilter,
          HTML::Pipeline::SanitizationFilter,
          HTML::Pipeline::TableOfContentsFilter,
        ], { gfm: true, unsafe: true, whitelist: allowlist, scope: 'highlight', anchor_icon: anchor_icon }
      end

      def anchor_icon
        '<i aria-hidden="true" class="fas fa-link"></i>'
      end

      def allowlist
        add_list = {
          attributes: {
            'blockquote' => ['class','data-lang'],
            'p' => ['lang', 'dir'],
            'a' => ['href'],
            'span' => ['class'],
            'pre' => ['lang', 'class'],
          }
        }
        HTML::Pipeline::SanitizationFilter::WHITELIST.deep_merge(add_list)
      end
  end
end
