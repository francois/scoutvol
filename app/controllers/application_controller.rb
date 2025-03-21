class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  # allow_browser versions: :modern

  around_action :set_locale

  private

  def set_locale(&action)
    locale = :"fr-CA"
    I18n.with_locale(locale, &action)
  end
end
