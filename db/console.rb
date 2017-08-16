require('pry-byebug')
require_relative('../models/albums')
require_relative('../models/artists')


artist1 = Artist.new({
  'name' => 'Oasis'
  })

artist1.save()

album1 = Album.new({
  'name' => 'Definately Maybe',
  'genre' => 'Rock',
  'artist_id' => artist1.id
  })

binding.pry
nil
