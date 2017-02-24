require 'rails_helper'
require 'support/login_helper'

RSpec.feature "Cards", type: :feature do
 
  let!(:user){create(:user, email: "test@test.test", password: "test", password_confirmation: "test")}
  let!(:pack){create(:pack, user_id: user.id)} 
  let(:card){create(:card)}

  before(:each) do 
    login("test@test.test", "test" )
   end

  feature "have selector pack" do 
    it "have_selector pack, option  techical " do
      visit new_card_path
      fill_in :card_original, :with => "a"
      fill_in :card_translated, :with => "az"
      select('techical', from: 'card_pack_id')
      click_button "Create Card"
      Card.last.update_attributes(review: -3.days.from_now)
      visit root_path
      click_link "techical"
      expect(page).to  have_content "Pack: techical"
    end
  end

   feature "have selector pack1" do 
    it "have_selector pack1, option  amb " do
      pack1 = create(:pack, name: 'amb', user_id: user.id) 
      visit new_card_path
      fill_in :card_original, :with => "atr"
      fill_in :card_translated, :with => "azr"
      select('amb', from: 'card_pack_id')
      click_button "Create Card"
      Card.last.update_attributes(review: -3.days.from_now)
      visit root_path
      click_link "amb"
      expect(page).to  have_content "Pack: amb"
    end
  end

end




