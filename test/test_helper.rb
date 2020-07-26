ENV['RAILS_ENV'] ||= 'test'

require 'simplecov'
SimpleCov.start 'rails'

require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
  def login_as(user)
    post login_url, params: { session: { name: user.name, password: 'password' } }
  end

  def switch_session_as(site)
    patch site_session_url params: { site: { id: site.id } }, format: :js
  end
end
