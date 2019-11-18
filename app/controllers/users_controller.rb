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
    if @user && !params["name"].empty? && !params["email"].empty? && !params["password"].empty?
      @user.save
      session[:user_id] = @user.id
      redirect '/items'
    else
    erb :'/registrations/signup'
    end
  end

  get '/sessions/login' do
    erb :'sessions/login'
  end

  post '/sessions' do
    user = User.find_by(email: params[:email]) # Looking up user by email
    @user = user.try(:authenticate, params[:password]) # Bcrypt magic to authenticate user by password
    if @user
      session[:user_id] = @user.id
      redirect '/items'
    end
    redirect '/sessions/login'
    end

  get '/sessions/logout' do
    session.clear
    redirect '/'
  end
end