class AddImageUrlToExercises < ActiveRecord::Migration[7.1]
  def change
    add_column :exercises, :image_url, :string
  end
end
