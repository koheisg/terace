require 'cloudflare'

class CloudflarePurgeJob < ApplicationJob
  def perform(permalink)
    return unless Rails.env.production?

    # Grab some details from somewhere:
    token = ENV['CLOUDFLARE_TOKEN']

    Cloudflare.connect(token: token) do |connection|
      zone = connection.zones.find_by_name('dreamin.cc') # rubocop:disable Rails/DynamicFindBy
      zone.purge_cache(files: ["https://#{permalink.site.domain}/#{permalink.path}"])
    end
  end
end
