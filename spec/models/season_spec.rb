require "rails_helper"

RSpec.describe Season, type: :model do
  it "sets a slug on create" do
    expect(Season.create!(name: "2024-2025").slug).not_to be_nil
  end

  it "keeps the existing slug on update" do
    expect { seasons(:s2024).update!(name: "Season 2024-2025") }.not_to change { seasons(:s2024).reload.slug }.from("j082g")
  end
end
