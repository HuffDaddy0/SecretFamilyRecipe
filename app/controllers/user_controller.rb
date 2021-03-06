class UserController < ApplicationController

    get "/users" do
        #! do i need this?
        erb :'users/profile'
    end

    get "/users/new" do
        erb :'User/signup'
    end

    post "/users/new" do
            @user = User.new(username: params[:username], password: params[:password])
            family = Family.find_by(name: params[:family][:name])
            if @user.save
                session[:user_id] = @user.id
                if family && family.validate(params[:family][:password])
                    @user.update(family: family)
                    @user.save
                    session[:user_id] = @user.id
                end
                redirect to "/users/#{@user.id}"
            else
                @errors = "Invalid Sign-up Information. Please try again."
                erb :"/User/signup"
            end 
    end

    get "/users/:id/fridge" do
        @user = User.find(params[:id])
        erb :'/User/fridge'
    end
    
    get "/users/:id" do
        @user = User.find_by(id: params[:id])
        erb :'/User/profile'
    end

    get "/users/:id/edit" do
        @user = User.find(params[:id])

    erb :'User/edit'
end

    patch "/users/:id" do
        @user = User.find(params[:id])
        if @user.authenticate(params[:current_password])
           @user.update(display_name: params[:display_name])
           @user.save 
           redirect "/users/#{@user.id}"
        else
        
            redirect "/users/#{current_user.id}"
        end
    end

    delete "/users/:id" do
        #! delete button on profile page. Only show up if current_user.id == :id
        user = User.find(params[:id])
        user.delete        
        #!Done
        redirect '/logout'
    end

end