class UserMailer < ApplicationMailer
  default from: 'darity.team@gmail.com'

  def thank_you(user, donation, title, description, daree)
    @user = user
    @donation = donation
    @title = title
    @description = description
    @daree = daree
    mail(to: @user.email, subject: "Thank you for your donation! Small acts, when multiplied by millions of people, can transform the world.")
  end

  def welcome_email(user)
    @user = user
    mail(to: @user.email, subject: "Darity welcomes you with open arms!")
  end

  def account_activation(user)
    @user = user
    mail(to: @user.email, subject: "Darity Account activation")
  end

  def password_reset(user)
    @user = user
    mail(to: @user.email, subject: "Darity Password Reset")
  end
end
