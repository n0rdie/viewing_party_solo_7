class Users::MoviesController < ApplicationController
    def index
        @user = User.find(params[:user_id])

        conn = Faraday.new("https://api.themoviedb.org") do |faraday|
            faraday.params["api_key"] = Rails.application.credentials.themoviedb[:key]
        end
        response = conn.get("/3/movie/top_rated")
        @hash = JSON.parse(response.body, symbolize_names: true)
        @movies = @hash[:results]

        # binding.pry
    end

    def show
        @user = User.find(params[:user_id])
        conn = Faraday.new("https://api.themoviedb.org") do |faraday|
            faraday.params["api_key"] = Rails.application.credentials.themoviedb[:key]
        end

        response = conn.get("/3/movie/#{params[:id]}")
        @movie = JSON.parse(response.body, symbolize_names: true)

        response = conn.get("/3/movie/#{params[:id]}/credits")
        @credits = JSON.parse(response.body, symbolize_names: true)

        response = conn.get("/3/movie/#{params[:id]}/reviews")
        @reviews = JSON.parse(response.body, symbolize_names: true)

        #binding.pry
    end
end