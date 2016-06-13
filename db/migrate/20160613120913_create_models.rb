class CreateModels < ActiveRecord::Migration
  def change
    create_table :models do |t|
      t.string :Movie
      t.string :title
      t.text :description
      t.string :movie_length
      t.string :director
      t.string :rating

      t.timestamps null: false
    end
  end
end
