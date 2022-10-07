# file: app.rb
require 'sinatra'
require "sinatra/reloader"
require_relative 'lib/database_connection'
require_relative 'lib/album_repository'
require_relative 'lib/artist_repository'

DatabaseConnection.connect

class Application < Sinatra::Base
  configure :development do
    register Sinatra::Reloader
    also_reload 'lib/album_repository'
    also_reload 'lib/artist_repository'
  end

  get '/albums' do
    repo = AlbumRepository.new
    @albums = repo.all
      
    return erb(:album)
  end

  # post '/albums' do 
  #   if invalid_request_album?
  #     status 400
  #     return ''
  #   end

  #   repo = AlbumRepository.new
  #   album = Album.new
  #   album.title = params[:title]
  #   album.release_year = params[:release_year]
  #   album.artist_id = params[:artist_id]

  #   repo.create(album)
  #   return erb(:new_album_success)
  # end

  get '/albums/new' do
    return erb(:new_album)
  end

  get '/artists' do
    repo = ArtistRepository.new
    @artists = repo.all
    
    return erb(:artists)
  end

  # post '/artists' do
  #   if invalid_request_artist?
  #     status 400
  #     return ''
  #   end
  #   repo = ArtistRepository.new
  #   new_artist = Artist.new
  #   new_artist.id = params[:id]
  #   new_artist.name = params[:name]
  #   new_artist.genre = params[:genre]

  #   repo.create(new_artist)
  #   return erb(:new_artist_success)
  # end

  get '/artists/new' do
    return erb(:new_artist)
  end

  get '/albums/:id' do
    album_repo = AlbumRepository.new
    artist_repo = ArtistRepository.new

    @album = album_repo.find(params[:id])

    @artist = artist_repo.find(@album.id)
    return erb(:albums)
  end

  get '/artists/:id' do
    artist_repo = ArtistRepository.new

    @artist = artist_repo.find(params[:id])
    return erb(:artist)
  end

  private 
  
  def invalid_request_artist?
    params[:name] == nil || params[:genre] == nil
  end

  def invalid_request_album?
    params[:title] == nil || params[:release_year] == nil || params[:artist_id] == nil
  end

end