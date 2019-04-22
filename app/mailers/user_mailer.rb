class UserMailer < ApplicationMailer
  default from: 'twinklestaryoshino@gmail.com'

  def alert_email(user)
    @user = user
    @url = 'https://agile-citadel-24997.herokuapp.com/'
    mail(to: @user.email, subject: 'the deadline for the task is coming.')
  end
end
