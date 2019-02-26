desc "This task is called by the Heroku scheduler add-on"
task :send_alert_mail => :environment do
  puts "Sending mail..."
  
  User.each do |user|
    user.tasks.each do |task|
    
    end
  end
  # NewsFeed.update
  puts "done."
end

task :send_reminders => :environment do
  User.send_reminders
end