class CreateShows < ActiveRecord::Migration[5.0]
  def change
    create_table :shows do |t|
      t.string :name
      t.string :city
      t.string :state
      t.datetime :closing_date
      t.datetime :show_date
      t.string :superintendent

      t.timestamps
    end
  end
end
