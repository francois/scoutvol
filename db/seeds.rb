# A list of slugs to use for seeding
#
# 6ivuf
# bxrjd
# qr3p4
# rsk41
# pewbg
# uiifw
# i78nn
# s2ffe

Attendance.delete_all
Registration.delete_all
Event.delete_all
Season.delete_all

season = Season.create!(name: "2024-2025", slug: "a9b8l")

vertetor = season.events.create!(title: "Vert & Or", slug: "ndj1c", start_at: "2025-10-04T10:00-0400", max_registrations: 12)
season.events.create!(title: "Vert & Or", slug: "vqcfp", start_at: "2025-10-14T10:00-0400", max_registrations: 12)

jan = [
  season.events.create!(title: "Cannet-🌎-thon janvier", slug: "jcxfo", start_at: "2026-01-11T09:00-0500", max_registrations: 4),
  season.events.create!(title: "Cannet-🌎-thon janvier", slug: "zxo7e", start_at: "2026-01-11T11:00-0500", max_registrations: 4),
  season.events.create!(title: "Cannet-🌎-thon janvier", slug: "8fcnw", start_at: "2026-01-11T13:00-0500", max_registrations: 4)
]

season.events.create!(title: "Cannet-🌎-thon mai", slug: "0kb9n", start_at: "2025-05-02T09:00-0400", max_registrations: 4)
season.events.create!(title: "Cannet-🌎-thon mai", slug: "rij8v", start_at: "2025-05-02T11:00-0400", max_registrations: 4)
season.events.create!(title: "Cannet-🌎-thon mai", slug: "eqgqk", start_at: "2025-05-02T13:00-0400", max_registrations: 4)

vertetor.record_registration!(person_name: "John Smith", registration_email: "john.smith@example.com", branch: "castors")
vertetor.record_registration!(person_name: "Jack Smith", registration_email: "john.smith@example.com", branch: "castors")
vertetor.record_registration!(person_name: "Jane Smith", registration_email: "john.smith@example.com", branch: "chouettes")
vertetor.record_registration!(person_name: "Jim Smith", registration_email: "john.smith@example.com", branch: "aigles")
vertetor.record_registration!(person_name: "Jimmy Smith", registration_email: "john.smith@example.com", branch: "éclaireurs")

jan[0].record_registration!(person_name: "John Smith", registration_email: "john.smith@example.com", branch: "chouettes")
jan[0].record_registration!(person_name: "Jack Smith", registration_email: "john.smith@example.com", branch: "chouettes")
jan[0].record_registration!(person_name: "Jane Smith", registration_email: "john.smith@example.com", branch: "aigles")
jan[1].record_registration!(person_name: "John Smith", registration_email: "john.smith@example.com", branch: "aigles")
jan[2].record_registration!(person_name: "Jane Smith", registration_email: "john.smith@example.com", branch: "aigles")
