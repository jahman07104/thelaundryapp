require './config/environment'
#require 'rack-flash'
class ApplicationController < Sinatra::Base
  configure do
    enable :sessions
    set :session_secret, "password_security"
    set :public_folder, 'public'
    set :views, 'app/views'
    register Sinatra::Flash
   end

   helpers do

    def current_user
      @user=User.find_by_id(session[:user_id])
    end
  
    def is_logged_in?
      !!current_user
    end

    def redirect_if_not_logged_In
      unless logged_in 
      flash[:error] = "You must be legged in to do that!"
      redirect "/registraton/signup" unless logged_in?
    end
   end  
end
end  
   