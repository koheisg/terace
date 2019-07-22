xml.instruct! :xml, :version => "1.0"
xml.rss(
  "version" => "2.0",
  "xmlns:content" => "http://purl.org/rss/1.0/modules/content/",
  "xmlns:wfw" => "http://wellformedweb.org/CommentAPI/",
  "xmlns:dc" => "http://purl.org/dc/elements/1.1/",
  "xmlns:atom" => "http://www.w3.org/2005/Atom",
  "xmlns:sy" => "http://purl.org/rss/1.0/modules/syndication/",
  "xmlns:slash" => "http://purl.org/rss/1.0/modules/slash/"
) do
  xml.channel do
    xml.title @site.name
    xml.description @site.description
    xml.link request.host_with_port
    xml.language "ja-ja"
    xml.ttl "40"
    xml.pubDate(Time.now.strftime("%a, %d %b %Y %H:%M:%S %Z"))
    xml.atom :link, "href" => "RSSのURL", "rel" => "self", "type" => "application/rss+xml"
    @articles.each do |p|
      xml.item do
        xml.title p.title
        xml.description do
          xml.cdata! p.content_html
        end
        xml.pubDate p.created_at #公開日
        xml.guid "#{request.protocol}#{request.host_with_port}/#{p.permalink}"
        xml.link "#{request.protocol}#{request.host_with_port}/#{p.permalink}"
      end
    end
  end
end
