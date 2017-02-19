require 'rails_helper'

RSpec.feature "Cards", type: :feature do
  before(:all) do 
    Card.destroy_all
    create(:card, original: "дом", translated: "Haus").update_attributes(review: Time.now)
    #let(:card){create(:card, original: "Стол", translated: "Table")}
   end
  feature "field test" do 
    it "field test" do
      visit root_path
      fill_in :text, :with => 'дом'
      click_button "Update Card"
      expect(page).to have_content "угадал"
    end
  end
end