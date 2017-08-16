require('pg')

class Album

  attr_accessor(:name, :genre)
  attr_reader(:id, :artist_id)

  def initialize(album_content)
    @name = album_content['name']
    @genre = album_content['genre']
    @id = album_content['id'].to_i if album_content['id']
    @artist_id = album_content['artist_id']
  end

  def save()
    db = PG.connect({dbname: 'music_app', host: 'localhost'})
    sql = '
      INSERT INTO albums(
      name,
      genre,
      artist_id
      )
      VALUES(
      $1, $2, $3
      )
      RETURNING id;'
    values = [@name, @genre, @artist_id]
    db.prepare('save', sql)
    artist_hash = db.exec_prepared('save', values)[0]
    @id = artist_hash['id'].to_i
    db.close()
  end

  def Album.all()
    db = PG.connect({dbname: 'music_app', host: 'localhost'})
    sql = 'SELECT * FROM albums'
    db.prepare('all', sql)
    albums = db.exec_prepared('all', [])
    db.close()
    return albums.map{ |album| Albums.new( album )}
  end

end
