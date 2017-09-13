source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?('/')
  "https://github.com/#{repo_name}.git"
end

gem 'bootstrap-sass', '~> 3.3.6'
gem 'clockwork', '~> 2.0.2', require: false
gem 'coffee-rails', '~> 4.2'
gem 'foreman'
gem 'jbuilder', '~> 2.5'
gem 'jquery-rails'
gem 'pg', '~> 0.18'
gem 'puma', '~> 3.7'
gem 'rails', '~> 5.1.4'
gem 'redis', '~> 3.0'
gem 'russian'
gem 'sass-rails', '~> 5.0'
gem 'sidekiq', '~> 5.0.4'
gem 'simple_form'
gem 'slim-rails', '~> 3.1.2'
gem 'uglifier', '>= 1.3.0'

group :development, :test do
  gem 'pry-byebug', '~> 3.5.0'
  gem 'pry-rails', '~> 0.3.6'
end

group :development do
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'rubocop', require: false
  gem 'web-console', '>= 3.3.0'
end

gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
