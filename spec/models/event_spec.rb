require "rails_helper"

RSpec.describe Event, type: :model do
  it "complains if the number of registrations exceeds max_registrations" do
    expect {
      events(:full_event).record_registration!(
        person_name: "Jane Smith",
        registration_email: "jane.smith@example.com",
        branch: "foo"
      )
    }.to raise_error(MaxRegistrationsExceeded)
      .and not_change { Registration.count }
  end

  it "accepts recording a registration on an event with some space" do
    expect {
      events(:free_event).record_registration!(
        person_name: "Jane Smith",
        registration_email: "jane.smith@example.com",
        branch: "foo"
      )
    }.to not_raise_error
      .and change { Registration.count }.by(1)
  end
end
