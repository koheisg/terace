source 'https://rubygems.org'
ruby '3.0.1'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem 'webpacker'
gem 'uglifier'
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
gem 'turbolinks'
gem 'terrace', path: 'terrace'
gem 'sass-rails'
gem 'sanitize'
gem 'rouge'
gem 'redis-rails'
gem 'rails'
gem 'puma'
gem 'pg'
gem 'mini_magick'
gem 'kaminari'
gem 'jbuilder'
gem 'html-pipeline-youtube'
gem 'html-pipeline'
gem 'front_matter_parser'
gem 'fishur', path: 'fishur'
gem 'escape_utils'
gem 'desk', path: 'desk'
gem 'cssbundling-rails'
gem 'commonmarker'
gem 'cloudflare'
gem 'bcrypt'
gem 'aws-sdk-s3'
gem "sentry-ruby"
gem "sentry-rails"

group :development, :test do
  gem 'selenium-webdriver'
  gem 'pry-rails'
  gem 'pry-byebug'
  gem 'dotenv-rails'
  gem 'capybara'
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
end

group :development do
  gem 'web-console'
  gem 'spring-watcher-listen'
  gem 'spring'
  gem 'rubocop-rails'
  gem 'rubocop-performance'
  gem 'rubocop'
  gem 'listen'
end

group :test do
  gem 'simplecov', require: false
end
