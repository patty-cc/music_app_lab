require('pg')

class Album

  def initialize(album_content)
    @name = album_content['name']
    @genre = album_content['genre']
    @id = album_content['id'].to_i if album_content['id']
    @artist_id = album_content['artist_id']
  end

end
