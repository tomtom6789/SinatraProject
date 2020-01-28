require './config/environment'
require 'rack-flash'


class ApplicationController < Sinatra::Base
  use Rack::Flash


  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "super_secret_code_word"
  end


  get "/" do
    erb :index
  end


  helpers do 
    def current_user 
      @user ||= User.find_by_id(session[:user_id])
    end 

    def logged_in?
      !!current_user
    end 

    def redirect_if_not_logged_in
      if !logged_in?
        redirect '/login'
      end 
    end 

    
  end 




  

end
