# file: lib/database_connection.rb

require 'pg'

# This class is a thin "wrapper" around the
# PG library. We'll use it in our project to interact
# with the database using SQL.

class DatabaseConnection
  # This method connects to PostgreSQL using the 
  # PG gem. We connect to 127.0.0.1, and select
  # the database name given in argument.
  # file: lib/database_connection.rb

  def self.connect
    # If the environment variable (set by Heroku)
    # is present, use this to open the connection.
    if ENV['https://data.heroku.com/datastores/72254897-2276-40fb-9675-c0019e1908b0'] != nil
      @connection = PG.connect(ENV['https://data.heroku.com/datastores/72254897-2276-40fb-9675-c0019e1908b0'])
      return
    end

    if ENV['ENV'] == 'test'
      database_name = 'music_library_test'
    else
      database_name = 'music_library'
    end
    @connection = PG.connect({ host: '127.0.0.1', dbname: database_name })
  end

  # This method executes an SQL query 
  # on the database, providing some optional parameters
  # (you will learn a bit later about when to provide these parameters).
  def self.exec_params(query, params)
    if @connection.nil?
      raise 'DatabaseConnection.exec_params: Cannot run a SQL query as the connection to'\
      'the database was never opened. Did you make sure to call first the method '\
      '`DatabaseConnection.connect` in your app.rb file (or in your tests spec_helper.rb)?'
    end
    @connection.exec_params(query, params)
  end
end