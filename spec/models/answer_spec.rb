require 'rails_helper'

RSpec.describe Answer, type: :model do
  let(:question) { Question.create!(title: "question title", body: "question text", resolved: false)}
  let(:answer) { Answer.create!(body: "answer text", question: question)}
  describe "attributes" do
      it "has attributes" do
          expect(answer).to have_attributes(body: "answer text")
      end
  end
end
