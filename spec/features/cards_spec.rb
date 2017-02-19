require 'rails_helper'

RSpec.feature "Cards", type: :feature do
  before(:each) do 
    #Card.destroy_all
    create(:card, original: "дом", translated: "Haus").update_attributes(review: Time.now)
    visit root_path
   end

  feature "field test" do 
    it "field test" do
      fill_in :text, :with => "дом"
      click_button "Update Card"
      expect(page).to have_content "угадал"
    end
  end

  feature "field test 2" do 
    it "field test 2" do
      fill_in :text, :with => "стол"
      click_button "Update Card"
      expect(page).to have_content "извините, неправильно"
    end
  end

end