require 'rails_helper'
require 'support/login_helper'

RSpec.feature "Cards", type: :feature do
 
  before(:each) do 
    user = create(:user, email: "test@test.test", password: "test", password_confirmation: "test") 
    pack =  create(:pack, user_id: user.id) 
    pack1 = create(:pack, name: 'technic', user_id: user.id) 
    create(:card, user_id: user.id, pack_id: pack.id).update_attributes(review: -3.days.from_now)
    visit root_path
    login("test@test.test", "test" )
   end

  feature "have selector" do 
    it "have_selector" do
      visit new_card_path
      fill_in :card_original, :with => "a"
      fill_in :card_translated, :with => "az"
      attach_file 'card_image', "#{Rails.root}/spec/images/ten.jpg"
      expect(page).to have_selector('#card_pack_id')
      click_button "Create Card"
      Card.last.update_attributes(review: -3.days.from_now)
      visit root_path
      expect(page).to  have_content "techical"
    end
  end

end




