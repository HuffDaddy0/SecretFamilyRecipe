class SessionController < ApplicationController
    
    get "/login" do
        #!Done
        erb :'/User/login'
    end

    post "/login" do
        #! Done
    user = User.find_by(username: params[:username])
        if user && user.authenticate(params[:password])
            session[:user_id] = user.id
           # binding.pry
            redirect "/"
        else
            @errors = "invalid username or password"
            erb :"/User/login"
        end
    end

    get "/logout" do
        #!Done
      session.clear
        redirect "/"
    end
 

end