class UsersController < ApplicationController

  get '/signup' do
    if logged_in?
      redirect '/tweets'
    else
      erb :'/users/signup'
    end
  end

  get '/login' do
    if logged_in?
      redirect '/tweets'
    else
      erb :'/users/login'
    end
  end

  get '/users/:slug' do
    @user = User.find(params[:slug])
    erb :'/user/show'
    if !logged_in?
      erb :'/users/signup'
    else
      redirect '/tweets'
    end
  end

  get '/login' do
    erb :'/users/login'
  end

  post '/signup' do
    if params[:username].empty? || params[:email].empty? || params[:password].empty?
      redirect '/signup'
    else
      user = User.new(:username=> params[:username], :email=> params[:email], :password=> params[:password])
      user.save
      session[:user_id] = user.id
      redirect '/tweets'
    end
  end

  post '/login' do
    user = User.find_by(:username=> params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect '/tweets'
    else
      redirect '/signup'
    end
  end

  get '/logout' do
      session.clear
      redirect '/login'
  end


end
