source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include? '/'
  "https://github.com/#{repo_name}.git"
end

gem 'puma', '~> 3.7'
gem 'rails', '~> 5.1.0'
gem 'sqlite3'

gem 'graphql'
gem 'search_object'
gem 'search_object_graphql'

group :development, :test do
  gem 'byebug', platforms: %i(mri mingw x64_mingw)
  gem 'graphiql-rails'
  gem 'rubocop'
  gem 'rubocop-rails'
end

group :development do
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'web-console', '>= 3.3.0'
end
