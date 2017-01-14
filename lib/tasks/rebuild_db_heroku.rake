desc 'This builds heroku button db'
task :build_db => :environment do
  Rake::Task["db:schema:load"].invoke
  Rake::Task["db:seed_fu"].invoke
  Rake::Task["db:seed"].invoke
  system("rake db:seed_fu FIXTURE_PATH=db/fixtures/requirements/2016")
  system("rake db:seed_fu FIXTURE_PATH=db/fixtures/users")

end