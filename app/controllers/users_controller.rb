class UsersController < ApplicationController 

    get '/signup' do 
        if logged_in?
            redirect '/favorites'
        else 
            erb :'/users/create_user'
        end 
    end 


    post '/signup' do 
        @user = User.new(params)
        if @user.save 
            session[:user_id] = @user.id 
            redirect '/favorites'
        else 
            flash[:notice] = 'Fields are blank or email is used. Please try again!'
            redirect '/signup'
        end 
    end 


    get '/login' do
        if !logged_in?
          erb :'/users/login'
        else
          redirect '/favorites'
        end
      end
    
      post '/login' do
        user = User.find_by(username: params[:username])
        if user && user.authenticate(params[:password])
          session[:user_id] = user.id
          redirect '/favorites'
        else
          flash[:notice] = "Please sign up to Favorite before login."
          redirect '/signup'
        end
      end
    
    
      
      get '/logout' do 
        if logged_in?
          session.clear
          redirect '/login'
        else 
          redirect '/'
        end 
      end 
    
    #   post '/logout' do 
    #     session.destroy
    #     redirect '/favorites'
    #   end 
    
    
    #   get '/users/:slug' do
    #     @user = User.find_by_slug(params[:slug])
    #     erb :'/users/show'
    #   end



end 