require 'rails_helper'

RSpec.describe Question, type: :model do
  let(:question) { Question.create!(title: "question title", body: "question content", resolved: false) }
  describe "attributes" do
      it "has attributes" do
          expect(question).to have_attributes(title: "question title", body: "question content", resolved: false)
      end
  end
end
