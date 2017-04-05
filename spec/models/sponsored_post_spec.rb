require 'rails_helper'

RSpec.describe SponsoredPost, type: :model do
  let(:title) { RandomData.random_sentence }
  let(:body) { RandomData.random_paragraph }
  let(:price) { rand(100) }
  let(:name) { RandomData.random_sentence }
  let(:description) { RandomData.random_paragraph }
  let(:topic) { Topic.create!(name: name, description: description) }
  let(:spost) { topic.sponsored_posts.create!(title: title, body: body, price: price) }
  
  it { is_expected.to belong_to(:topic) }
  
  describe "attributes" do
    it "has the correct attributes" do
      expect(spost).to have_attributes(title: title, body: body, price: price)
    end
  end
end
