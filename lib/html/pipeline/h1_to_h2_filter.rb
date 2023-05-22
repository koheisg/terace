require 'html/pipeline'

module HTML
  class Pipeline
    class H1ToH2Filter < Filter
      def call
        doc.search('h1').each do |h1|
          h2 = Nokogiri::XML::Node.new('h2', doc)
          h2.content = h1.content
          h1.replace(h2)
        end

        doc
      end
    end
  end
end
