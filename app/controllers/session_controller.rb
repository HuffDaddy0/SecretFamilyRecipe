class SessionController < ApplicationController
    
    get "/login" do
        erb :'/User/login'
    end

    post "/login" do
    user = User.find_by(username: params[:username])
        if user && user.authenticate(params[:password])
            session[:user_id] = user.id
            redirect "/"
        else
            @errors = "invalid username or password"
            erb :"/User/login"
        end
    end

    get "/logout" do
      session.clear
        redirect "/"
    end
 

end