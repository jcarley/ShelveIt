class CreateEarMarks < ActiveRecord::Migration
  def self.up
    create_table :ear_marks do |t|
      t.string :url
      t.string :name
      t.datetime :date_saved

      t.timestamps
    end
  end

  def self.down
    drop_table :ear_marks
  end
end
