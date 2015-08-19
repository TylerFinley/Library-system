require('capybara/rspec')
require('./app')
require('spec_helper')
Capybara.app = Sinatra::Application
set(:show_exceptions, false)

  describe('adding a new book with author and genre', {:type => :feature}) do
    it('allows user to see and add books') do
      visit('/')
      click_button('View Books')
      fill_in("title", :with => "50 shades of grey")
      fill_in('author', :with => "E.L. James")
      fill_in('genre', :with => "Erotic")
      click_button("Add Book")
      expect(page).to_have_content('50 shades of grey')
    end
  end
