class CreateRatings < ActiveRecord::Migration[5.2]
  def change
    create_table :ratings do |t|
      t.string :email, index: true
      t.string :description
      t.integer :rating

      t.belongs_to :course, index: true
      t.belongs_to :professor, index: true

      t.timestamps
    end
  end
end
