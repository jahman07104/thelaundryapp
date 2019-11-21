class ItemsController < ApplicationController
  get '/items' do
    @items = Item.all
    erb :'/items/index'
  end

  post '/items' do
    @item = Item.new(params["item"])
    if @item && !params["item"]["name"].empty? && !params["item"]["description"].empty?
      #binding.pry
      @item.user_id = current_user.id 
      @item.save
      redirect to "/items/#{@item.id}"
    else
      erb :'/items/new'
    end
  end

  get '/items/new' do
    @items = Item.all
    erb :'/items/new'
  end

  get '/items/:id' do
   @item = Item.find_by_id(params[:id])
   erb :'items/show'
  end

  get '/items/:id/edit' do
    @item = Item.find(params[:id])
    erb :'items/edit'
  end

  patch '/items/:id' do  
    @item =Item.find(params[:id])
    #binding.pry
    @item.update(name: params[:name], description: params[:description])
    @item.save
    flash[:message] = "Item Successfully Updated!"
    redirect to "/items"
  end

  delete '/items/:id/delete' do
    @item = Item.find_by_id(params[:id])
    @item 
    @item=Item.find_by_id(params[:id]).destroy
    flash[:message] = "Item Successfully Deleted!"
    redirect to "/items"
  end
end

