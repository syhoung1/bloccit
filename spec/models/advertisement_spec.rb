require 'rails_helper'

RSpec.describe Advertisement, type: :model do
  let(:advertisement) {Advertisement.create!(title: "title", body: "body", price: 3) }
  describe "attributes" do
    it "has title, body, and price attributes" do
      expect(advertisement).to have_attributes(title: "title", body: "body", price: 3)
    end
  end
end
