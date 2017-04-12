require 'rails_helper'
include SessionsHelper

RSpec.describe CommentsController, type: :controller do
  let(:my_user) { create(:user) }
  let(:other_user) { create(:user) }
  let(:my_topic) { create(:topic) }
  let(:my_post) { (create(:post, topic: my_topic, user: my_user)) }
  let(:my_comment) { my_post.comments.create!(body: "Comment Body", user: my_user, post: my_post) }
  
  context "guest" do
    describe "POST create" do
      it "redirects the user to the sign in view" do
        post :create, post_id: my_post.id, comment: { body: "Comment" }
        expect(response).to redirect_to(new_session_path)
      end
    end
    
    describe "DELETE destroy" do
      it "redirects the user to the sign in view" do
        delete :destroy, post_id: my_post.id, id: my_comment.id
        expect(response).to redirect_to(new_session_path)
      end
    end
  end
  
  context "member doing CRUD on a comment they don't own" do
    before do
      create_session(other_user)
    end
    
    describe "POST create" do
      it "increases the number of comments by 1" do
        expect{ post :create, post_id: my_post.id, comment: { body: RandomData.random_sentence } }.to change(Comment, :count).by(1)
      end
      
      it "redirects to the post show view" do
        post :create, post_id: my_post.id, comment: { body: RandomData.random_sentence }
        expect(response).to redirect_to([my_topic, my_post])
      end
    end
    
    describe "DELETE destroy" do
      it "redirects to the post show view" do
        delete :destroy, post_id: my_post.id, id: my_comment.id
        expect(response).to redirect_to([my_topic, my_post])
      end
    end
  end
  
  context "member doing CRUD on a comment they own" do
    before do
      create_session(my_user)
    end
    
    describe "POST create" do
      it "changes the comments count by 1" do
        expect{ post :create, post_id: my_post.id, comment: { body: "comment body" } }.to change(Comment, :count).by(1)
      end
      
      it "redirects to the post show view" do
        post :create, post_id: my_post.id, comment: { body: "comment body" }
        # formatted this way to pass into redirect_to?
        expect(response).to redirect_to([my_topic, my_post])
      end
    end
    
    describe "DELETE destroy" do
      it "deletes the comment" do
        delete :destroy, post_id: my_post.id, id: my_comment.id
        expect(Comment.where({id: my_comment.id}).count).to eq(0)
      end
      
      it "redirects to the post show view" do
        delete :destroy, post_id: my_post.id, id: my_comment.id
        expect(response).to redirect_to([my_topic, my_post])
      end
    end
  end
  
  context "admin doing CRUD on a comment they don't own" do
    before do
      # turns other_user into admin
      other_user.admin!
      create_session(other_user)
    end
    
    describe "POST create" do
      it "changes the comments count by 1" do
        expect{ post :create, post_id: my_post.id, comment: { body: "comment body" } }.to change(Comment, :count).by(1)
      end
      
      it "redirects to the post show view" do
        post :create, post_id: my_post.id, comment: { body: "comment body" }
        expect(response).to redirect_to([my_topic, my_post])
      end
    end
    
    describe "DELETE destroy" do
      it "deletes the comment" do
        delete :destroy, post_id: my_post.id, id: my_comment.id
        expect(Comment.where({id: my_comment.id}).count).to eq(0)
      end
      
      it "redirects to the post show view" do
        delete :destroy, post_id: my_post.id, id: my_comment.id
        expect(response).to redirect_to([my_topic, my_post])
      end
    end
  end
end
