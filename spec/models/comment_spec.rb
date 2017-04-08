require 'rails_helper'

RSpec.describe Comment, type: :model do
  let(:user) { User.create!(name: "johnny", email: "johnny@john.com", password: "thispassword") }
  let(:topic) { Topic.create!(name: RandomData.random_sentence, description: RandomData.random_paragraph) }
  let(:post) { topic.posts.create!(title: "New title", body: "New post content new post content", user: user) }
  let(:comment) { Comment.create!(body: "Comment", post: post) }

  describe "attributes" do
    it "has a body attribute" do
      expect(comment).to have_attributes(body: "Comment")
    end
  end
end
