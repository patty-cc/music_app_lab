require('pg')

class Artist

  attr_accessor(:name)
  attr_reader(:id)

  def initialize(artist_details)
    @id = artist_details['id'].to_i if artist_details['id']
    @name = artist_details['name']
  end

  def album()
    db = PG.connect({dbname: 'music_app', host: 'localhost'})
    sql = 'SELECT * FROM albums
    WHERE artist_id = $1;'
    db.prepare('album', sql)
    result_array = db.exec_prepared('album', [@id])
    album_object = result_array.map{ |album| Album.new(album)}
    # album_array = result_array[0]
    # album_object = Album.new( album_array )
    db.close()
    return album_object
  end

  def save()
    db = PG.connect({dbname: 'music_app', host: 'localhost'})
    sql = '
      INSERT INTO artists (
      name
      )
      VALUES (
      $1
      )
      RETURNING *;'
    values = [@name]
    db.prepare('save', sql)
    returned_data = db.exec_prepared('save', values)
    @id = returned_data[0]['id'].to_i
    db.close()
  end

  def Artist.all()
    db = PG.connect({dbname: 'music_app', host: 'localhost'})
    sql = 'SELECT * FROM artists'
    db.prepare('all', sql)
    artists = db.exec_prepared('all', [])
    db.close()
    return artists.map{ |artist| Artist.new( artist )}
  end

end
