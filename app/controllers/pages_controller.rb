class PagesController < ApplicationController
    def home
        require 'net/http'
        require 'json'
        @id = User.find(session[:user_id]).id
        # httpx.rb
        # require "httpx"

        # response = HTTPX.get("https://api.themoviedb.org/3/trending/all/day?api_key=360a9b5e0dea438bac3f653b0e73af47&language=en-US")
        # @film = JSON.parse(response.body)
        # @films = @film["results"]

        @url="https://api.themoviedb.org/3/trending/all/day?api_key=360a9b5e0dea438bac3f653b0e73af47&language=en-US"
        @uri = URI(@url)
        @response = Net::HTTP.get(@uri)
        @film = JSON.parse(@response)
        @films = @film["results"]
    end
   def view
    film_id=params[:film_id]
    @id=params[:id]
    require 'net/http'
    require 'json'
    @url="https://api.themoviedb.org/3/movie/#{film_id}?api_key=360a9b5e0dea438bac3f653b0e73af47&language=en-US"
    @uri = URI(@url)
    @response = Net::HTTP.get(@uri)
    @film = JSON.parse(@response)
    @data = @film
    @urlr="https://api.themoviedb.org/3/movie/#{film_id}/recommendations?api_key=360a9b5e0dea438bac3f653b0e73af47&language=en-US&page=1"
    @urir = URI(@urlr)
    @responser = Net::HTTP.get(@urir)
    @filmr = JSON.parse(@responser)
    @recs = @filmr["results"]
   end
   def cart
    @film_id=params[:film_id]
    @id=params[:id]
    @title=params[:title]
    @cost=params[:cost]
    @user = User.find(session[:user_id]).id
    @cart = Cart.new(film_id: @film_id, user_id: @id, title: @title, cost: @cost)
    @cart.save
    @cartb=Cart.where(user_id: @user)
    redirect_to "/carts/#{@id}"
   end
    def carts
        @id=params[:id]
        @user = User.find(session[:user_id]).id
        @cartb=Cart.where(user_id: @user)
    end
    def delcart
        @id=params[:id]
        @cart=Cart.find(@id)
        @cart.destroy
        @user = User.find(session[:user_id]).id
        @cartb=Cart.where(user_id: @user)
        redirect_to "/carts/#{@user}"
    end
    def buy
        @id=params[:id]
        @film_id=params[:film_id]
        @title=params[:title]
        @cost=params[:cost]
        @cartid=params[:cartid]
        @user = User.find(session[:user_id]).id
        @buy = Buy.new(film_id: @film_id, user_id: @id, title: @title, cost: @cost)
        @buy.save
        @cart=Cart.find(@cartid)
        @cart.destroy
        @buy=Buy.where(user_id: @user)
        redirect_to "/buys/#{@user}"
    end
    def buys
        @id=params[:id]
        @user = User.find(session[:user_id]).id
        @buy=Buy.where(user_id: @user)
    end
    def delbuy
        @id=params[:id]
        @buy=Buy.find(@id)
        @buy.destroy
        @user = User.find(session[:user_id]).id
        redirect_to "/buys/#{@user}"
    end
end