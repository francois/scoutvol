class MetricsController < ApplicationController
  def show
    @season = Season.includes(events: :registrations).find_by!(slug: params[:season_slug])
    @max_registrations = @season.events.map(&:max_registrations).sum
    @registrations_count = @season.events.flat_map(&:registrations).group_by(&:branch).transform_values(&:count)
  end
end
