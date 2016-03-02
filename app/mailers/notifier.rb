class Notifier < ActionMailer::Base
  helper :application

  default from: "service@mobilityempowered.com"

  # grant access as organization admin
  def new_organization_admin_welcome(organization, user)
    @organization = organization
    @user = user

    mail(to: user.email, subject: "You're now admin of #{org.name}")
  end

  # link to reset password
  def new_user_welcome(organization, user)
    @user = user
    @organization = organization

    # must regenerate new token for each new email
    @token = @user.reset_password_token!

    mail(to: user.email, subject: "Welcome to Mobility Empowered")
  end

  # grant access to new organization
  def new_organization_access_welcome(organization, user)
    @organization = organization
    @user = user

    mail(to: user.email, subject: "You're granted access to #{organization.name}")
  end

end
