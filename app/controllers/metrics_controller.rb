class MetricsController < ApplicationController
  def show
    @season = Season.includes(events: :registrations).find_by!(slug: params[:season_slug])
    @max_registrations = @season.events.map(&:max_registrations).sum
    @registrations_count = @season.events.flat_map(&:registrations).group_by(&:branch).transform_values(&:count)
  end

  def registrations
    start_on = params[:start_on].to_date || Time.zone.today
    bounds = 2.days.before(start_on)...5.days.after(start_on)

    @season = Season.includes(events: :registrations).find_by!(slug: params[:season_slug])
    @events = @season.events.select { it.start_at.in?(bounds) }
  end
end
