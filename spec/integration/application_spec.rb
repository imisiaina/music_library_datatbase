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
      expect(response.body).to eq "Pixies, ABBA, Taylor Swift, Nina Simone"
    end
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

end
