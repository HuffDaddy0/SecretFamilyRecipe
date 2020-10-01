class FamilyController < ApplicationController

    get "/families" do
        if logged_in? && users_family
            erb :'Family/show' #!Do i need this route??
        else
            redirect "/families/new"
        end
    end

    get "/families/new" do
        #! Done
        erb :'/Family/new'
    end

    get "/families/join" do
        if logged_in?
            erb :'/Family/join'
        else
            redirect '/families/join'
        end
    end

    post "/families/join" do
        family = Family.find_by(name: params[:name])
        binding.pry
        if family && family.authenticate(params[:password])
            current_user.family = family
            current_user.save

            redirect "/families/#{family.id}"
        end

        redirect "/families/join"
    end

    post "/families/new" do
        if params[:family_name] != "" && pass_match(params[:family_password], params[:vfamily_password])
            @family = Family.new(name: params[:family_name], password: params[:family_password])
            @family.users << current_user
            if @family.save
                @family.update(admin_user_id: current_user.id)
                @family.save
           
            redirect "/families/#{@family.id}"
            else
            redirect "/families/new"
            end
        else 
            redirect "/families/new"
        end 
    end

    get "/families/:id" do
        family = Family.find(params[:id])
        if family
            @family = family

            erb :'/Family/show'
        else
            redirect "/families/#{current_user.family.id}"
        end
    end

    get "/families/:id/edit" do
        @family = Family.find(params[:id])

        erb :"Family/edit"
    end

    patch "/families/:id" do
        params.delete_if {|k,v| k == 'submit' || k == "_method"}
        @family = Family.find(params[:id])
        @family.validate(params[:family_password])
        @family.update(name: params[:name])
        @family.save

        redirect "/families/#{@family.id}"    
    end

    delete "/families/:id" do
        fam = Family.find(params[:id])
        fam.delete
        
        redirect '/'
    end

end

