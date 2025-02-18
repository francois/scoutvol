class RegistrationsController < ApplicationController
  def index
    @season = Season.includes(events: {registrations: {}})
      .strict_loading
      .where(events: {start_at: Time.now..})
      .find_by!(slug: params[:season_slug])
  end

  def new
    @event = Event.includes(registrations: {}, season: {})
      .strict_loading
      .find_by!(slug: params[:event_slug])
    @form = Registration::Form.new(people: Array.new(@event.num_free_registrations) { Registration::Person.new })
  end

  def create
    # Can't use strict_loading here because #record_registration reloads the registrations association
    @event = Event.includes(registrations: {}, season: {}).find_by!(slug: params[:event_slug])
    @form = Registration::Form.new
    @form.email = create_params[:email]
    @form.people = create_params[:people].values.select { _1[:name].present? }.map { Registration::Person.new(_1) }.compact

    if @form.valid? && @form.people.all?(&:valid?)
      Event.transaction do
        registrations = @form.people.map do |person|
          @event.record_registration!(person_name: person.name, registration_email: @form.email, branch: person.branch)
        end

        RegistrationMailer.with(registrations:).registration_confirmation.deliver_later
      end
      redirect_to registrations_path(season_slug: @event.season.slug), notice: "#{@form.people.size} présence(s) enregistrée(s)"
    else
      render action: :new, status: :unprocessable_entity
    end
  rescue MaxRegistrationsExceeded
    flash.now[:alert] = "Désolé, une autre personne a pris la dernière place. Veuillez trouver une autre date."
    render action: :new, status: :unprocessable_entity
  end

  private

  def create_params
    params.require(:registration).permit(:email, people: [:name, :branch])
  end
end
