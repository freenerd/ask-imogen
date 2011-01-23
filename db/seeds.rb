# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)

tracks = []
tracks << {
  :track_id => 6307130,
  :user_id => 1232518,
  :permalink => "eddie-morton-somebody-else-is-gettin-it",
  :title => "Somebody Else is Gettin It",
  :user_permalink => "thisisparker",
  :artwork_url => "http://i1.soundcloud.com/avatars-000001472284-h6z4vz-crop.jpg",
  :waveform_url => "http://waveforms.soundcloud.com/yTACN8xTDy0o_m.png",
  :user_username => "thisisparker"
}

tracks << {
  :track_id => 2,
  :user_id => 193,
  :permalink => "oberholz5",
  :title => "Electro 1",
  :user_permalink => "eric",
  :artwork_url => "http://waveforms.soundcloud.com/KcoNolQWb1bB_m.png",
  :waveform_url => "http://i1.soundcloud.com/avatars-000002132069-wserv8-crop.jpg",
  :user_username => "Eric"
}

questions = []
10.times do
  question_raw = tracks.shuffle.first
  question = Track.create(question_raw.merge(
    :track_created_at => Time.now - rand(1000).to_int.minutes)
  )

  question.title = "Q#{question.id}"
  question.save!

  qa = Qa.create(:question => question, :question_number => question.id, :questioner_twitter_username => "freenerd")

  if rand(100) > 50 #answer some questions
    answer = Track.create(tracks.shuffle.first.merge(
      :track_created_at => Time.now - rand(1000).to_int.minutes)
    )

    answer.title = "A#{qa.question_number}"
    answer.save!

    qa.answer = answer
    qa.save!
  end
end
