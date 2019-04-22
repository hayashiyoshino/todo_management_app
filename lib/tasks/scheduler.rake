desc "This task is called by the Heroku scheduler add-on"
task :send_alert_mail => :environment do
  puts "Sending mail..."
  
  User.each do |user|
    limit_tasks = user.tasks.includes(:user).where(deadline: Date.current..Date.current+3)
    if limit_tasks != nil
      UserMailer.alert_email(user).deliver_later
    end
  end
  puts "done."
end
