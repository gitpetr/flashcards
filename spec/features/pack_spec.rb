require 'rails_helper'
require 'support/login_helper'

RSpec.feature "Cards", type: :feature do
 
  before(:each) do 
    user = create(:user, email: "test@test.test", password: "test", password_confirmation: "test") 
    pack =  create(:pack, user_id: user.id) 
    pack1 = create(:pack, name: 'amb', user_id: user.id) 
    create(:card, user_id: user.id, pack_id: pack.id).update_attributes(review: -3.days.from_now)
    visit root_path
    login("test@test.test", "test" )
   end

  feature "have selector pack" do 
    it "have_selector pack, option  techical " do
      visit new_card_path
      fill_in :card_original, :with => "a"
      fill_in :card_translated, :with => "az"
      #select('techical', from: 'card_pack_id')
      attach_file 'card_image', "#{Rails.root}/spec/images/ten.jpg"
      click_button "Create Card"
      Card.last.update_attributes(review: -3.days.from_now)
      visit root_path
      expect(page).to  have_content "Pack: techical"
    end
  end

   feature "have selector pack1" do 
    it "have_selector pack, option  amb " do
      visit new_card_path
      fill_in :card_original, :with => "atr"
      fill_in :card_translated, :with => "azr"
      select('amb', from: 'card_pack_id')
      attach_file 'card_image', "#{Rails.root}/spec/images/ten.jpg"
      click_button "Create Card"
      Card.last.update_attributes(review: -3.days.from_now)
      visit root_path
      click_link "amb"
      expect(page).to  have_content "Pack: amb"
    end
  end

end




