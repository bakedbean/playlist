Factory.define :tune do |tune|
  tune.url          "/tunes/new_song.mp3"
  tune.title        "New Song"
  tune.artist_name  "Some Dude"
  tune.duration     120
end

Factory.define :rating do |rating|
  rating.value 3
  rating.association :tune
end