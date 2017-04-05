require 'rails_helper'

RSpec.describe SponsoredPostsController, type: :controller do
  let(:my_topic) { Topic.create!(name: RandomData.random_sentence, description: RandomData.random_paragraph) }
  let(:my_spost) { my_topic.sponsored_posts.create!(title: RandomData.random_sentence, body: RandomData.random_paragraph, price: rand(100)) }
  describe "GET show" do
    it "returns http success" do
      get :show, topic_id: my_topic.id, id: my_spost.id
      expect(response).to have_http_status(:success)
    end

    it "renders the show view" do
      get :show, topic_id: my_topic.id, id: my_spost.id
      expect(response).to render_template :show
    end

    it "assigns my_spost to @sponsored_post" do
      get :show, topic_id: my_topic.id, id: my_spost.id
      expect(assigns(:sponsored_post)).to eq(my_spost)
    end
  end
  
  describe "GET new" do
    it "returns http success" do
      get :new, topic_id: my_topic.id
      expect(response).to have_http_status(:success)
    end
    
    it "renders the new view" do
      get :new, topic_id: my_topic.id
      expect(response).to render_template :new
    end
    
    it "instantiatest a new sponsored post" do
      get :new, topic_id: my_topic.id
      expect(assigns(:sponsored_post)).not_to be_nil
    end
  end
  
  describe "GET edit" do
    it "returns http success" do
      get :edit, topic_id: my_topic.id, id: my_spost.id
      expect(response).to have_http_status(:success)
    end
    
    it "renders the edit view" do
      get :edit, topic_id: my_topic.id, id: my_spost.id
      expect(response).to render_template(:edit)
    end
    
    it "assigns the sponsored post to be edited to @sponsored_post" do
      get :edit, topic_id: my_topic.id, id: my_spost.id
      spost_instance = assigns(:sponsored_post)
      
      expect(spost_instance.id).to eq my_spost.id
      expect(spost_instance.title).to eq my_spost.title
      expect(spost_instance.body).to eq my_spost.body
    end
  end
end
