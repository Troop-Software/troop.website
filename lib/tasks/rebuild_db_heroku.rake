desc 'This rebuilds Heroku db'
task :rebuild_db_heroku => :environment do
  system('heroku pg:reset DATABASE')
  system('heroku run rails db:schema:load')
  system('heroku run rails db:seed_fu')
  system('heroku run rails db:seed_fu FIXTURE_PATH=db/fixtures/requirements/2016')
  system('heroku run rails db:seed_fu FIXTURE_PATH=db/fixtures/users')

end