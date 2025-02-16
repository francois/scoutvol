# Prevents an I18n::MissingTranslationData: Translation missing: en.faker.name.first_name (I18n::MissingTranslationData)
I18n.available_locales = %i[en]
I18n.default_locale = :en

SLUGS = %w[a9b8l ndj1c vqcfp jcxfo zxo7e 8fcnw 0kb9n rij8v eqgqk]
BRANCHES =
  [
    Array.new(20) { "castors" },
    Array.new(18) { "chouettes" },
    Array.new(18) { "aigles" },
    Array.new(16) { "éclaireurs" },
    Array.new(8) { "pionniers" },
    Array.new(3) { "routiers" }
  ].flatten.map(&:freeze).freeze

def seed_registrations(num, event)
  num.times do
    event.record_registration!(
      person_name: Faker::Name.name,
      registration_email: Faker::Internet.email,
      branch: BRANCHES.sample
    )
  end
end

def next_saturday_on_or_after(datetime)
  datetime += 1.day while datetime.wday != 6
  datetime
end

def next_sunday_on_or_after(datetime)
  datetime += 1.day while datetime.wday != 0
  datetime
end

Attendance.delete_all
Registration.delete_all
Event.delete_all
Season.delete_all

tz = ActiveSupport::TimeZone["America/Montreal"]

seasons = 2.times.map { Date.today.year + _1 }.map do |start_year|
  Season.create!(name: "#{start_year}-#{start_year.succ}", slug: SLUGS.shift)
end

seasons.each do |season|
  season.events.create!(title: "Vert & Or", start_at: next_sunday_on_or_after(tz.local(season.name.to_i, 8, 29, 10)), slug: SLUGS.shift, max_registrations: 12).tap { seed_registrations(4, _1) }
  season.events.create!(title: "Vert & Or", start_at: next_sunday_on_or_after(tz.local(season.name.to_i, 9, 10, 10)), slug: SLUGS.shift, max_registrations: 12).tap { seed_registrations(8, _1) }
  season.events.create!(title: "Vert & Or", start_at: next_saturday_on_or_after(tz.local(season.name.to_i, 10, 1, 10)), slug: SLUGS.shift, max_registrations: 12)
  season.events.create!(title: "Vert & Or", start_at: next_saturday_on_or_after(tz.local(season.name.to_i, 10, 15, 10)), slug: SLUGS.shift, max_registrations: 12)

  season.events.create!(title: "Cannet-🌎-thon des fêtes", start_at: next_saturday_on_or_after(tz.local(season.name.to_i.succ, 1, 4, 9)), slug: SLUGS.shift, max_registrations: 6).tap { seed_registrations(6, _1) }
  season.events.create!(title: "Cannet-🌎-thon des fêtes", start_at: next_saturday_on_or_after(tz.local(season.name.to_i.succ, 1, 4, 11)), slug: SLUGS.shift, max_registrations: 6)
  season.events.create!(title: "Cannet-🌎-thon des fêtes", start_at: next_saturday_on_or_after(tz.local(season.name.to_i.succ, 1, 4, 13)), slug: SLUGS.shift, max_registrations: 6)
  season.events.create!(title: "Cannet-🌎-thon des fêtes", start_at: next_saturday_on_or_after(tz.local(season.name.to_i.succ, 1, 4, 15)), slug: SLUGS.shift, max_registrations: 6)

  season.events.create!(title: "Cannet-🌎-thon des fêtes", start_at: next_saturday_on_or_after(tz.local(season.name.to_i.succ, 1, 5, 9)), slug: SLUGS.shift, max_registrations: 6).tap { seed_registrations(5, _1) }
  season.events.create!(title: "Cannet-🌎-thon des fêtes", start_at: next_saturday_on_or_after(tz.local(season.name.to_i.succ, 1, 5, 11)), slug: SLUGS.shift, max_registrations: 6).tap { seed_registrations(2, _1) }
  season.events.create!(title: "Cannet-🌎-thon des fêtes", start_at: next_saturday_on_or_after(tz.local(season.name.to_i.succ, 1, 5, 13)), slug: SLUGS.shift, max_registrations: 6).tap { seed_registrations(5, _1) }
  season.events.create!(title: "Cannet-🌎-thon des fêtes", start_at: next_saturday_on_or_after(tz.local(season.name.to_i.succ, 1, 5, 15)), slug: SLUGS.shift, max_registrations: 6).tap { seed_registrations(1, _1) }

  season.events.create!(title: "Cannet-🌎-thon de Pâques", start_at: next_saturday_on_or_after(tz.local(season.name.to_i.succ, 5, 1, 9)), slug: SLUGS.shift, max_registrations: 6)
  season.events.create!(title: "Cannet-🌎-thon de Pâques", start_at: next_saturday_on_or_after(tz.local(season.name.to_i.succ, 5, 1, 11)), slug: SLUGS.shift, max_registrations: 6)
  season.events.create!(title: "Cannet-🌎-thon de Pâques", start_at: next_saturday_on_or_after(tz.local(season.name.to_i.succ, 5, 1, 13)), slug: SLUGS.shift, max_registrations: 6)
  season.events.create!(title: "Cannet-🌎-thon de Pâques", start_at: next_saturday_on_or_after(tz.local(season.name.to_i.succ, 5, 1, 15)), slug: SLUGS.shift, max_registrations: 6)

  season.events.create!(title: "Cannet-🌎-thon de Pâques", start_at: next_saturday_on_or_after(tz.local(season.name.to_i.succ, 5, 2, 9)), slug: SLUGS.shift, max_registrations: 6)
  season.events.create!(title: "Cannet-🌎-thon de Pâques", start_at: next_saturday_on_or_after(tz.local(season.name.to_i.succ, 5, 2, 11)), slug: SLUGS.shift, max_registrations: 6)
  season.events.create!(title: "Cannet-🌎-thon de Pâques", start_at: next_saturday_on_or_after(tz.local(season.name.to_i.succ, 5, 2, 13)), slug: SLUGS.shift, max_registrations: 6)
  season.events.create!(title: "Cannet-🌎-thon de Pâques", start_at: next_saturday_on_or_after(tz.local(season.name.to_i.succ, 5, 2, 15)), slug: SLUGS.shift, max_registrations: 6)

  season.events.create!(title: "Phoenix", start_at: next_sunday_on_or_after(tz.local(season.name.to_i, 11, 17, 18)), slug: SLUGS.shift, max_registrations: 8)
  season.events.create!(title: "Phoenix", start_at: next_sunday_on_or_after(tz.local(season.name.to_i, 12, 21, 20)), slug: SLUGS.shift, max_registrations: 8).tap { seed_registrations(3, _1) }
  season.events.create!(title: "Phoenix", start_at: next_sunday_on_or_after(tz.local(season.name.to_i.succ, 2, 24, 16)), slug: SLUGS.shift, max_registrations: 8)
  season.events.create!(title: "Phoenix", start_at: next_sunday_on_or_after(tz.local(season.name.to_i.succ, 3, 8, 17)), slug: SLUGS.shift, max_registrations: 8)

  season.events.create!(title: "Pif", start_at: tz.local(season.name.to_i.succ, 6, 27, 22), slug: SLUGS.shift, max_registrations: 10)
  season.events.create!(title: "Pif", start_at: tz.local(season.name.to_i.succ, 6, 28, 22), slug: SLUGS.shift, max_registrations: 10).tap { seed_registrations(9, _1) }
  season.events.create!(title: "Pif", start_at: tz.local(season.name.to_i.succ, 6, 29, 22), slug: SLUGS.shift, max_registrations: 10).tap { seed_registrations(10, _1) }
  season.events.create!(title: "Pif", start_at: tz.local(season.name.to_i.succ, 6, 30, 22), slug: SLUGS.shift, max_registrations: 10)
  season.events.create!(title: "Pif", start_at: tz.local(season.name.to_i.succ, 7, 1, 22), slug: SLUGS.shift, max_registrations: 10)
end
