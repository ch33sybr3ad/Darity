class UserMailer < ApplicationMailer
  default from: 'darity.team@gmail.com'

  def thank_you(pledger)
    @pledger = pledger
    @url = pay_donations_path
    mail(to: @pledger.email, subject: "Thank you for your donation! Small acts, when multiplied by millions of people, can transform the world.")
  end
end
