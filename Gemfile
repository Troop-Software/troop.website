source 'https://rubygems.org'


gem 'rails', '~> 5.0.0', '>= 5.0.0.1'
gem 'puma', '~> 3.0'
source 'https://rails-assets.org' do
  gem 'rails-assets-tether', '>= 1.1.0'
end
gem 'bootstrap-sass', '~> 3.3.6'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.2'
gem 'fullcalendar-rails'
gem 'momentjs-rails'
gem 'jquery-ui-rails'
gem 'bootstrap3-datetimepicker-rails'
gem 'will_paginate'
gem 'will_paginate-bootstrap'
gem 'devise'
gem 'devise_zxcvbn'
gem 'font-awesome-rails'
gem 'jquery-rails'
#gem 'turbolinks', '~> 5'
#gem 'jquery-turbolinks'
gem 'jbuilder', '~> 2.5'
gem 'bcrypt', '~> 3.1.7'
gem 'seed-fu'
gem 'has_scope'
gem 'faker'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

group :production do
  gem 'pg'
end

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platform: :mri
  gem 'sqlite3'
  gem 'rspec-rails'
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'web-console'
  gem 'listen', '~> 3.0.5'
end

group :test do
  gem 'capybara'
  gem 'database_cleaner'
  gem 'simplecov'
  gem 'rspec_junit_formatter'
  gem 'minitest-ci', :git => 'git@github.com:circleci/minitest-ci.git'

end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
