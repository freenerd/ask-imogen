class CreateQas < ActiveRecord::Migration
  def self.up
    create_table :qas do |t|
      t.integer :question_id
      t.integer :answer_id
      t.string :questioner_twitter_username

      t.timestamps
    end
  end

  def self.down
    drop_table :qas
  end
end
