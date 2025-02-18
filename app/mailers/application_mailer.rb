class ApplicationMailer < ActionMailer::Base
  default from: ENV["DEFAULT_MAIL_FROM"]
  layout "mailer"

  before_action :set_locale

  private

  def set_locale
    I18n.locale = :"fr-CA"
  end
end
