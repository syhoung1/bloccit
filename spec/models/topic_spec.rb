require 'rails_helper'

RSpec.describe Topic, type: :model do
  let(:name) { RandomData.random_sentence }
  let(:public) { true }
  let(:description) { RandomData.random_paragraph }
  let(:topic) { Topic.create!(name: name, description: description) }

  it { is_expected.to have_many(:posts) }

  describe "attributes" do
    it "has the correct attributes" do
      expect(topic).to have_attributes(name: name, description: description, public: public)
    end

    it "has public by default" do
      expect(topic.public).to be(true)
    end
  end
end
