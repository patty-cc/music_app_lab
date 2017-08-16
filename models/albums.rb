require('pg')

class Album

  attr_accessor(:name, :genre)
  attr_reader(:id, :artist_id)

  def initialize(album_content)
    @title = album_content['title']
    @genre = album_content['genre']
    @id = album_content['id'].to_i if album_content['id']
    @artist_id = album_content['artist_id']
  end

  def artist()
    db = PG.connect({dbname: 'music_app', host: 'localhost'})
    sql = 'SELECT * FROM artists
    WHERE id = $1;'
    db.prepare('artist', sql)
    result_array = db.exec_prepared('artist', [@artist_id])
    artist_array = result_array[0]
    artist_object = Artist.new(artist_array)
    return artist_object
    db.close()


  end

  def save()
    db = PG.connect({dbname: 'music_app', host: 'localhost'})
    sql = '
      INSERT INTO albums(
      title,
      genre,
      artist_id
      )
      VALUES(
      $1, $2, $3
      )
      RETURNING id;'
    values = [@title, @genre, @artist_id]
    db.prepare('save', sql)
    artist_hash = db.exec_prepared('save', values)[0]
    @id = artist_hash['id'].to_i
    db.close()
  end

  def update()
    db = PG.connect({dbname: 'music_shop', host: 'localhost'})
    sql = 'UPDATE albums SET(
    name
    ) = (
    $1, $2, $3
    )
    WHERE id = $4'
    values = [@title, @genre, @artist_id, @id]
    db.prepare('update', sql)
    db.exec_prepared('update', values)
    db.close()
  end

  def Album.all()
    db = PG.connect({dbname: 'music_app', host: 'localhost'})
    sql = 'SELECT * FROM albums;'
    db.prepare('all', sql)
    albums = db.exec_prepared('all', [])
    db.close()
    return albums.map{ |album_array| Album.new( album_array )}
  end

  def Album.delete_all()
    db = PG.connect({dbname: 'music_app', host: 'localhost'})
    sql = 'DELETE FROM albums;'
    db.exec(sql)
    db.close
  end

end
