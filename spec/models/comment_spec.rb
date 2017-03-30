require 'rails_helper'

RSpec.describe Comment, type: :model do
  let(:post) { Post.create!(title: "New title", body: "New post content") }
  let(:comment) { Comment.create!(body: "Comment", post: post) }
  describe "attributes" do
      it "has a body attribute" do
          expect(comment).to have_attributes(body: "Comment")
      end
  end
end
