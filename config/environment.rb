ENV['SINATRA_ENV'] ||= "developement"

require 'bundler/setup'
Bundler.require(:default, ENV['SINATRA_ENV'])
set :database_file, "./database.yml"
Dotenv.load if ENV['SINATRA_ENV'] == "development"



require_all 'app'
require 'pry'
