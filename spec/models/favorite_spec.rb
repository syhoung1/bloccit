require 'rails_helper'

RSpec.describe Favorite, type: :model do
  let(:topic) { Topic.create!(name: RandomData.random_sentence, description: RandomData.random_paragraph) }
  let(:user) { User.create!(name: RandomData.random_name, email: RandomData.random_email, password: RandomData.random_sentence) }
  let(:post) { topic.posts.create(title: RandomData.random_sentence, body: RandomData.random_paragraph) }
  let(:favorite) { Favorite.create(user: user, post: post) }
  
  it { is_expected.to belong_to(:user) }
  it { is_expected.to belong_to(:post) }
end
