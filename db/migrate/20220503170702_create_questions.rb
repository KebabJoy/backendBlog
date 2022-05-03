class CreateQuestions < ActiveRecord::Migration[6.0]
  def change
    create_table :questions do |t|
      t.string :title
      t.text :body
      t.references :author, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end
