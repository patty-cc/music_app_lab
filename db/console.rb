require('pry-byebug')
require_relative('../models/albums')
require_relative('../models/artists')

Album.delete_all()
Artist.delete_all()


artist1 = Artist.new({
  'name' => 'Oasis'
  })

artist1.save()

artist2 = Artist.new({
  'name' => 'Stereophonics'
  })

artist2.save()

album1 = Album.new({
  'title' => 'Definately Maybe',
  'genre' => 'Rock',
  'artist_id' => artist1.id
  })
  album1.save()

album2 = Album.new({
  'title' => 'Heathen Chemistry',
  'genre' => 'Rock',
  'artist_id' => artist1.id
  })
  album2.save()

album3 = Album.new({
  'title' => 'Word Gets Around',
  'genre' => 'Indie',
  'artist_id' => artist2.id
  })
  album3.save()

album4 = Album.new({
  'title' => 'J.E.E.P',
  'genre' => 'Indie',
  'artist_id' => artist2.id
  })
  album4.save()

binding.pry
nil
