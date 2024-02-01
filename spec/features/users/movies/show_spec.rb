require 'rails_helper'

RSpec.describe 'Movies Index', type: :feature do
    before(:each) do
        @user_1 = User.create!(name: 'Tommy', email: 'tommy@email.com')
    end

    it '3. Movie Details Page' do
        VCR.use_cassette("themoviedb_movie_cassette_2", :allow_playback_repeats => true) do
            #When I visit a movie's detail page (`/users/:user_id/movies/:movie_id`)
            visit "/users/#{@user_1.id}/discover"
            click_on('Discover Top Rated Movies')
            click_on('The Godfather Part II')
            # - a button to Create a Viewing Party
            expect(page).to have_button('Create a Viewing Party')
            # - a button to return to the Discover Page
            expect(page).to have_button('Discover')
            # - Movie Title
            expect(page).to have_content('The Godfather Part II')
            # - Vote Average of the movie
            expect(page).to have_content('8.592')
            # - Runtime in hours & minutes
            expect(page).to have_content('3h 22m')
            # - Genre(s) associated to movie
            expect(page).to have_content('Drama')
            expect(page).to have_content('Crime')
            # - Summary description
            expect(page).to have_content('In the continuing')
            expect(page).to have_content('Hollywood and Cuba.')
            # - List the first 10 cast members (characters & actress/actors)
            #expect(page).to have_content('Cast:', count: 10)
            #expect(page).to have_content('Al Pacino')
            # - Count of total reviews
            # - Each review's author and information
        end
    end
end