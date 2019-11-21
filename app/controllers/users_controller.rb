require 'pry'

class UsersController < ApplicationController
  get '/' do
    erb :'/users/home'
  end

  get '/registrations/signup' do
    erb :'/registrations/signup'
  end

  post '/registrations' do
    @user = User.new(name: params["name"], email: params["email"], password: params["password"])
      if @user.save
        session[:user_id] = @user.id
        redirect '/items'
      end
      flash[:error] = "User Already Exists!"
      redirect '/sessions/login'
   end

  get '/sessions/login' do
    erb :'sessions/login'
  end

  post '/sessions' do
    user = User.find_by(email: params[:email]) # Looking up user by email
    if user.try(:authenticate, params[:password]) # Bcrypt magic to authenticate user by password
      session[:user_id] = user.id
      redirect '/items'
    end
    flash[:error] = "All Field are required!"
    redirect '/sessions/login'
  end

  get '/sessions/logout' do
    session.clear
    redirect '/'
  end
end