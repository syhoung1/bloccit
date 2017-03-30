class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.string :title
      t.text :body
      t.boolean :resolved
      t.has_many :answers
      
      t.timestamps null: false
    end
  end
end
