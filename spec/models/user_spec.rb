require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { User.create!(name: 'john', email: 'john@john.com', password: 'password') }
  
  it { is_expected.to have_many(:posts) }
  it { is_expected.to have_many(:comments) }
  it { is_expected.to have_many(:votes) }
  it { is_expected.to have_many(:favorites) }

  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_length_of(:name).is_at_least(1) }

  it { is_expected.to validate_presence_of(:email) }
  it { is_expected.to validate_length_of(:email).is_at_least(3) }
  it { is_expected.to validate_uniqueness_of(:email) }
  it { is_expected.to allow_value('john@john.com').for(:email) }

  it { is_expected.to validate_presence_of(:password) }
  it { is_expected.to validate_length_of(:password).is_at_least(6) }
  it { is_expected.to have_secure_password }

  describe 'attributes' do
    it 'should have the correct name and email attributes' do
      expect(user).to have_attributes(name: 'john', email: 'john@john.com', password: 'password')
    end
    
    it 'responds to role' do
      expect(user).to respond_to(:role)
    end
    
    it 'responds to admin' do
      expect(user).to respond_to(:admin?)
    end
    
    it 'responds to member' do
      expect(user).to respond_to(:member?)
    end
  end
  
  describe 'roles' do
    
    it 'is a member by default' do
      expect(user.role).to eql("member")
    end
    
    context 'member user' do
      it 'returns true for #member' do
        expect(user.member?).to be_truthy
      end
      
      it 'returns fals for admin' do
        expect(user.admin?).to be_falsey
      end
    end
    
    context 'admin user' do

      before do
        user.admin!
      end
      
      it 'returns false for member' do
        expect(user.member?).to be_falsey
      end
      
      it 'returns true for admin' do
        expect(user.admin?).to be_truthy
      end
    end
  end

  describe 'invalid user' do
    let(:user_with_invalid_name) { User.new(name: '', email: 'john@john.com') }
    let(:user_with_invalid_email) { User.new(name: 'john', email: '') }

    it 'should be an invalid user name due to blank name' do
      expect(user_with_invalid_name).to_not be_valid
    end
    
    it 'should be an invalid email due to blank email' do
      expect(user_with_invalid_email).to_not be_valid
    end
  end
  
  describe '#favorite_for(post)' do
    before do
      topic = Topic.create!(name: RandomData.random_sentence, description: RandomData.random_paragraph)
      @post = topic.posts.create!(title: RandomData.random_sentence, body: RandomData.random_paragraph, user: user)
    end
    
    it "returns nil if the user has not favorited a post" do
      expect(user.favorite_for(@post)).to be_nil
    end
    
    it "returns the appropriate post for favorite" do
      favorite = user.favorites.where(post: @post).create
      expect(user.favorite_for(@post)).to eq(favorite)
    end
  end
end

