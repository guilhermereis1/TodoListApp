namespace :register do
  desc "Register users"
  task users: :environment do
    sh "rake db:drop db:create db:migrate"
    User.create!(
      email: 'gui@gmail.com',
      password: '123123',
      password_confirmation: '123123'
     )
     
     User.create!(
      email: 'gui+1@gmail.com',
      password: '123123',
      password_confirmation: '123123'
     )
  end
end
