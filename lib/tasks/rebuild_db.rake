desc 'This rebuilds development db'
task :rebuild_db => :environment do
  Rake::Task["db:drop"].invoke
  Rake::Task["db:create"].invoke
  Rake::Task["db:migrate"].invoke
  Rake::Task["db:seed_fu"].invoke
  Rake::Task["db:seed"].invoke
  system("rake db:seed_fu FIXTURE_PATH=db/fixtures/requirements/2016")
  system("rake db:seed_fu FIXTURE_PATH=db/fixtures/users")

end