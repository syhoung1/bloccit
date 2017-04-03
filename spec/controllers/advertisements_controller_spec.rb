require 'rails_helper'

RSpec.describe AdvertisementsController, type: :controller do
  let(:my_ad) { Advertisement.create!(title: RandomData.random_sentence, body: RandomData.random_paragraph, price: rand(100)) }
  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end

    it "assigns [my_ad] to advertisements" do
      get :index
      expect(assigns(:advertisements)).to eq([my_ad])
    end
  end

  describe "GET #show" do
    it "returns http success" do
      get :show, {id: my_ad.id}
      expect(response).to have_http_status(:success)
    end
    
    it "renders the show view" do
      get :show, {id: my_ad.id}
      expect(response).to render_template(:show)
    end
    
    it "assigns my_ad to @advertisement" do
      get :show, {id: my_ad.id}
      expect(assigns(:advertisement)).to eq(my_ad)
    end
  end

  describe "GET #new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end
    
    it "renders the new view" do
      get :new
      expect(response).to render_template(:new)
    end
    
    it "instantiates @advertisement" do
      get :new
      expect(assigns(:advertisement)).not_to be_nil
    end
  end

  describe "advertisement #create" do
    it "increases number of advertisements by 1" do
      get :new
      expect{post :create, advertisement: { title: RandomData.random_sentence, body: RandomData.random_paragraph, price: rand(100) }}.to change(Advertisement, :count).by(1)
    end
    
    it "assigns new ad to @advertisement" do
      post :create, advertisement: { title: RandomData.random_sentence, body: RandomData.random_paragraph, price: rand(100) }
      expect(assigns(:advertisement)).to eq Advertisement.last
    end
    
    it "redirects to the new ad" do
      post :create, advertisement: { title: RandomData.random_sentence, body: RandomData.random_paragraph, price: rand(100) }
      expect(response).to redirect_to Advertisement.last
    end
  end

end
