require 'rails_helper'
require 'capybara/rspec'

RSpec.feature "Cards", type: :feature do


 

  describe "one 1"  do 
  #  before(:each) do 
  #   let!(:card){create(:card, original: "дом", translated: "Haus", review: "2017-02-10")}
  # end

    it "can start flashcard" do 
      visit root_path 
      expect(page).to have_content "Флэшкарточкер"
    end

  end

end


