require 'rails_helper'
include SessionsHelper

RSpec.describe VotesController, type: :controller do
  let(:my_user) { User.create!(name: RandomData.random_name, password: RandomData.random_sentence, email: RandomData.random_email) }
  let(:other_user) { User.create!(name: RandomData.random_name, password: RandomData.random_sentence, email: RandomData.random_email, role: :member) }
  let(:my_topic) { Topic.create!(name: RandomData.random_sentence, description: RandomData.random_paragraph) }
  let(:user_post) { my_topic.posts.create!(title: RandomData.random_sentence, body: RandomData.random_paragraph, user: my_user) }
  let(:other_user_post) { my_topic.posts.create!(title: RandomData.random_sentence, body: RandomData.random_paragraph, user: other_user) }
  let(:my_vote) { Vote.create!(value: 1) }
  
  context "guest" do
    describe "post up vote" do
      it "redirects user to the sign in view" do
        post :up_vote, post_id: user_post.id
        expect(response).to redirect_to(new_session_path)
      end
    end
    
    describe "post down vote" do
      it "redirects user to the sign in view" do
        post :down_vote, post_id: user_post.id
        expect(response).to redirect_to(new_session_path)
      end
    end
  end
  
  context "signed in user" do
    before do
      create_session(my_user)
      request.env["HTTP_REFERER"] = topic_post_path(my_topic, user_post)
    end
    
    describe "POST up_vote" do
      it "increases the user's vote count by 1 the first time only" do
        votes = other_user_post.votes.count
        post :up_vote, post_id: other_user_post.id
        expect(other_user_post.votes.count).to eq(votes + 1)
      end
      
      it "does not increase the number of votes the second time and on" do
        post :up_vote, post_id: user_post.id
        votes = user_post.votes.count
        post :up_vote, post_id: user_post.id
        expect(user_post.votes.count).to eq(votes)
      end
      
      it "increase the sum of votes by 1" do
        points = other_user_post.points
        post :up_vote, post_id: other_user_post.id
        expect(other_user_post.points).to eq(points + 1)
      end
      
      it ":back redirects to posts show page" do
        request.env["HTTP_REFERER"] = topic_post_path(my_topic, user_post)
        post :up_vote, post_id: user_post.id
        expect(response).to redirect_to([my_topic, user_post])
      end
      
      it ":back redirects to posts topic show" do
        request.env["HTTP_REFERER"] = topic_path(my_topic)
        post :up_vote, post_id: user_post.id
        expect(response).to redirect_to(my_topic)
      end
    end
    
    describe "POST down_vote" do
      it "increases the number of votes by 1" do
        votes = other_user_post.votes.count
        post :down_vote, post_id: other_user_post.id
        expect(other_user_post.votes.count).to eq(votes + 1)
      end
      
      it "does not increase the number of votes the second time" do
        post :down_vote, post_id: user_post.id
        votes = user_post.votes.count
        post :down_vote, post_id: user_post.id
        expect(user_post.votes.count).to eq(votes)
      end
      
      it "decreases the sum of post votes by 1" do
        points = other_user_post.points
        post :down_vote, post_id: other_user_post.id
        expect(other_user_post.points).to eq(points - 1)
      end
      
      it ":back redirects to posts show page" do
        request.env["HTTP_REFERER"] = topic_post_path(my_topic, user_post)
        post :down_vote, post_id: user_post.id
        expect(response).to redirect_to([my_topic, user_post])
      end
      
      it ":back redirects to posts topic page" do
        request.env["HTTP_REFERER"] = topic_path(my_topic)
        post :down_vote, post_id: user_post.id
        expect(response).to redirect_to(my_topic)
      end
    end
  end
end
