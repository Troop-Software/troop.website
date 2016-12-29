desc 'This rebuilds Heroku db'
task :rebuild_db => :environment do
  system('heroku pg:reset DATABASE')
  system('heroku db:schema:load')
  system('heroku rails db:seed_fu')
  system('heroku rails db:seed_fu FIXTURE_PATH=db/fixtures/requirements/2016')
  system('heroku rails db:seed_fu FIXTURE_PATH=db/fixtures/users')

end