class AttendancesController < ApplicationController
  def root
    @season = Season.includes(events: {registrations: {}, attendances: {}})
      .find_by!(slug: params[:season_slug])
    @events = @season.events
      .where(start_at: ActiveSupport::TimeZone["America/Montreal"].now.change(hour: 4)..).order(:start_at)
      .to_a
    render
  end

  def index
    @event = Event.find_by!(slug: params[:event_slug])
    @people = @event.registrations.includes(:attendance).index_by(&:person_name)
      .merge(@event.attendances.index_by(&:person_name))
      .values
    render
  end

  def create
    @event = Event.find_by!(slug: params[:event_slug])
    if (registration_slug = params[:registration_slug]).present?
      @event.record_attendance!(registration_slug)
    elsif (attendance_slug = params[:attendance_slug]).present?
      @event.flip_attendance!(attendance_slug)
    elsif (person_name = params[:person_name]).present? && (branch = params[:branch]).present?
      @event.record_new_attendance!(person_name:, branch:)
    end

    redirect_to attendances_path(@event.slug)
  end
end
