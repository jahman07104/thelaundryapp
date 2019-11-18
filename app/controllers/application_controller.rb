require './config/environment'
#require 'rack-flash'
class ApplicationController < Sinatra::Base
  configure do
    enable :sessions
    set :session_secret, "password_security"
    set :public_folder, 'public'
    set :views, 'app/views'

   # use Rack::Flash
  end

   helpers do
    def current_user
      @user=User.find_by_id(session[:user_id])
    end
  
    def is_logged_in?
      !!current_user
    end
  
   
  end
end  
   