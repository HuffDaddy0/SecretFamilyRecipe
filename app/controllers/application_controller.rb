require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, 'CeE191416.1-4-6'
  end

  get "/" do
    # binding.pry
    erb :home
  end

  helpers do
    def current_user
        User.find(session[:user_id])
    end

    def logged_in?
        !!session[:user_id]
    end

    def pass_match(pass1, pass2)
      pass1 == pass2
    end
   
    def users_family
      current_user.family
    end

    def family_admin
      User.find(@family.admin_user_id)
    end

    def find_admin
      
      User.find()
    end

  end
end
