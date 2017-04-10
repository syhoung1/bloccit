require 'rails_helper'

RSpec.describe Comment, type: :model do
  let(:user) { User.create!(name: "johnny", email: "johnny@john.com", password: "thispassword") }
  let(:topic) { Topic.create!(name: RandomData.random_sentence, description: RandomData.random_paragraph) }
  let(:post) { topic.posts.create!(title: "New title", body: "New post content new post content", user: user) }
  let(:comment) { Comment.create!(body: "Comment", post: post, user: user) }
  
  it { is_expected.to belong_to(:post) }
  it { is_expected.to belong_to(:user) }
  
  it { is_expected.to validate_presence_of(:body) }
  it { is_expected.to validate_length_of(:body).is_at_least(5) }

  describe "attributes" do
    it "has a body attribute" do
      expect(comment).to have_attributes(body: "Comment")
    end
  end
end
