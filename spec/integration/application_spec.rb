require "spec_helper"
require "rack/test"
require_relative '../../app'

describe Application do
  # This is so we can use rack-test helper methods.
  include Rack::Test::Methods

  # We need to declare the `app` value by instantiating the Application
  # class so our tests work.
  let(:app) { Application.new }

  context "GET /artists" do
    it 'returns 200 OK' do
      response = get("/artists")
      expect(response.status).to eq (200)
      expect(response.body).to include('Name: <a href="/artists/1">Pixies</a>')
    end
  end

  it 'should add a link to each artist' do
    response = get('/artists/1')
    expect(response.status).to eq(200)
    expect(response.body).to include('Pixies')
  end



  # context "POST /artists" do
  #   it 'returns 200 OK' do
  #     response = post('/artists', id: 5, name: "Wild nothing", genre: "Indie")

  #     expect(response.status).to eq(200)
  #     expect(response.body).to eq('')

  #     response = get('/artists')
  #     expect(response.body).to include("Wild nothing")
  #   end
  # end

  # context "GET /albums" do
  #   it 'returns info about all albums' do
  #     response = get('/albums')
  #     expect(response.status).to eq(200)
  #     expect(response.body).to include('Title: Doolittle')
  #     expect(response.body).to include('Released: 1989')
  #   end
  # end

  context "GET /albums/:id" do
    it 'returns info about 1 album' do
      response = get('/albums/1')
      expect(response.status).to eq(200)
      expect(response.body).to include('<h1>Doolittle</h1>')
      expect(response.body).to include('Release year: 1989')
      expect(response.body).to include('Artist: Pixies')
    end
  end

  it 'should add a link to each album' do
    response = get('/albums')
    expect(response.status).to eq(200)
    expect(response.body).to include('<a href="/albums/1">Doolittle</a>')
  end

  context "GET /albums/new" do
    it 'returns the form page' do
      response = get('/albums/new')
      expect(response.status).to eq(200)
      expect(response.body).to include('<h1>Add an album</h1>')
      expect(response.body).to include('<form action="/albums" method="POST">')
    end
  end

  context "POST /albums" do
    it 'return a success page' do
      response = post('/albums', title: 'Album1', release_year: '2012', artist_id: '1')
      expect(response.status).to eq(200)
      expect(response.body).to include('<p>Your Album has been added</p>')
    end
    
    it 'returns 400 status' do
      response = post('/albums', title1: 'Album1', release_year: '2012', artist_id: '1')
      expect(response.status).to eq(400)
    end
  end

  context "GET /artists/new" do
    it 'returns the form page' do
      response = get('/artists/new')
      expect(response.status).to eq(200)
      expect(response.body).to include('<h1>Add an artist</h1>')
      expect(response.body).to include('<form action="/artists" method="POST">')
    end
  end

  context "POST /artists" do
    it 'return a success page' do
      response = post('/artists', name: 'MJ', genre: 'Pop')
      expect(response.status).to eq(200)
      expect(response.body).to include('<p>Your Artist has been added</p>')
    end
  end

  it 'returns 400 status' do
    response = post('/artists', name1: 'Album1', genre: '2012')
    expect(response.status).to eq(400)
  end
end
