class Users::MoviesController < ApplicationController
    def index
        @user = User.find(params[:user_id])

        conn = Faraday.new("https://api.themoviedb.org") do |faraday|
            faraday.params["api_key"] = Rails.application.credentials.themoviedb[:key]
        end
        response = conn.get("/3/movie/top_rated")
        @hash = JSON.parse(response.body, symbolize_names: true)
        @movies = @hash[:results]

        require 'pry'
        #binding.pry
    end
end