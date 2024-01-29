require 'rails_helper'

RSpec.describe 'Create New User', type: :feature do
    before(:each) do
      @user_1 = User.create!(name: 'Tommy', email: 'tommy@email.com')
    end

    it '1. Discover Movies: Search by Title' do
        # When I visit the '/users/:id/discover' path (where :id is the id of a valid user),
        visit "/users/#{@user_1.id}/discover"
        # I should see
        # - a Button to Discover Top Rated Movies
        expect(page).to have_button('Discover Top Rated Movies')
        # - a text field to enter keyword(s) to search by movie title
        expect(page).to have_field('title')
        # - a Button to Search by Movie Title
        expect(page).to have_button('Search by Movie Title')
        save_and_open_page
    end
end