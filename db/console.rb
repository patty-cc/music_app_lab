require('pry-byebug')
require_relative('../models/albums')
require_relative('../models/artists')


artist1 = Artist.new({
  'name' => 'Oasis'
  })

artist1.save()

album1 = Album.new({
  'title' => 'Definately Maybe',
  'genre' => 'Rock',
  'artist_id' => artist1.id
  })

album2 = Album.new({
  'title' => 'Heathen Chemistry',
  'genre' => 'Rock',
  'artist_id' => artist1.id
  })

album1.save()
album2.save()  

binding.pry
nil
