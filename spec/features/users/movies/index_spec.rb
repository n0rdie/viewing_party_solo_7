require 'rails_helper'

RSpec.describe 'Movies Index', type: :feature do
  before(:each) do
    @user_1 = User.create!(name: 'Tommy', email: 'tommy@email.com')
  end

  it '2. Movie Results Page' do
    VCR.use_cassette("themoviedb_movie_cassette_1") do
      # When I visit the discover movies page ('/users/:id/discover'),
      visit "/users/#{@user_1.id}/discover"
      # and click on either the Discover Top Rated Movies button or fill out the movie title search and click the Search button,
      click_on('Discover Top Rated Movies')
      # I should be taken to the movies results page (`users/:user_id/movies`) where I see:
      expect(current_path).to eq("/users/#{@user_1.id}/movies")
      # - Title (As a Link to the Movie Details page (see story #3))
      expect(page).to have_content('The Godfather')
      # - Vote Average of the movie
      expect(page).to have_content('8.7')

      #save_and_open_page

      # I should also see a button to return to the Discover Page.
      expect(page).to have_button('Discover')
      click_on('Discover')
      expect(current_path).to eq("/users/#{@user_1.id}/discover")
    end
  end
end