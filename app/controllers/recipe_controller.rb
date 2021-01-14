class RecipeController < ApplicationController
    
    get "/recipes" do
        #!Done
    
        erb :'Recipe/recipes'
    end

    get "/recipes/new" do
        #!Done

        erb :'Recipe/new'
    end

    # get "/recipes/search"do
    #     #! Done

    #     erb :'Recipe/search'
    # end  

    # post "/recipe/search" do
    #     #! Figure out search form, and how to find from that form
    #     Recipe.find_by()
    # end

    post "/recipes/new" do
        #binding.pry
        recipe = Recipe.create(
            cook_hours: params[:cook_hours],
            cook_minutes: params[:cook_minutes],
            ingredients: params[:ingredients],
            instructions: params[:instructions],
            pub: params[:pub],
            name: params[:name],
            prep_minutes: params[:prep_minutes],
            prep_hours: params[:prep_hours],
            user: current_user
        )
       # binding.pry
        recipe.save
        
        redirect "/recipes/#{recipe.id}"
    end

    get "/recipes/:id" do
        recipe = Recipe.find(params[:id])
        if recipe
            @recipe = recipe

            erb :'Recipe/show'
        else

        end
    end

    get "/recipes/:id/edit" do
        @recipe = Recipe.find(params[:id])
        
        erb :'Recipe/edit'
    end
    
    patch "/recipes/:id" do
        params.delete_if {|k,v| k == 'submit' || k == "_method"}
        @recipe = Recipe.find(params[:id])
        @recipe.update(params)
        @recipe.save

        redirect "/recipes/#{@recipe.id}"
    end

    delete "/recipes/:id" do
        recipe = Recipe.find(params[:id])
        recipe.delete

        redirect "/recipes"
    end


    helpers do
        def find_last_5_public
            Recipe.where(pub: true).last(5)
        end

        def find_last_5_family
            users_family.recipes.where(pub: false).last(5)
        end

        def sorted_public
            @recipe = Recipe.where(pub: true).all.sort_by {|recipe| recipe.name.downcase}
        end
    end
end