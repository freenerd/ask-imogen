class CreateTracks < ActiveRecord::Migration
  def self.up
    create_table :tracks do |t|
      t.integer :track_id
      t.datetime :track_created_at
      t.integer :user_id
      t.string :permalink
      t.string :title
      t.string :user_permalink
      t.string :artwork_url
      t.string :waveform_url
      t.string :user_username
      t.string :user_avatar_url

      t.timestamps
    end
  end

  def self.down
    drop_table :tracks
  end
end
