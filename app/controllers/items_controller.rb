class ItemsController < ApplicationController
  get '/items' do
    @items = Item.all
    erb :'/items/index'
  end

  get '/items/new' do
    @users = User.all
    erb :'/items/new'
  end

  post '/items' do
    @item = Item.new(params["item"])
    #binding.pry
    if @item && !params["item"]["name"].empty? && !params["item"]["description"].empty?
     @item.user_id = current_user.id 
      @item.save
      redirect to "/items/#{@item.id}"
    else
      erb :'/items/new'
    end
  end

  get '/items/:id' do
   @item = Items.find(params[:id])

      erb :'items/show'
   end

  get '/items/:id/edit' do
    @item = Item.find(params[:id])
  
      erb :'items/edit'
  end

  get '/items/:id/edit' do
    @item =Item.find_by_current_user(params[:id])
    erb :'/items/edit'
  end

    patch '/item/:id' do 
      redirect_if_not_logged_in?
     @item =Item.find(params[:id])
     if @item
      @item.update(name: params[:name], description: params[:description])
      redirect to "/items/#{@items.id}"
     @item.save
       #binding.pry
     else
      erb :'/items/edit'
  end 
end

    delete '/items/:id/delete' do
    @item = Item.find_by_id(params[:id])
   @item 
      @item=Item.find(params[:id]).destroy
      flash[:message] = "Item Successfully Deleted!"
    redirect to "/items"
  end
end
