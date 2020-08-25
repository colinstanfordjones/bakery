feature 'Cooking cookies' do
  before(:each) do
    @time = Time.now
    travel_to  @time - 3.minutes
  end

  after(:each) do
    travel_back
  end

  scenario 'Cooking a single cookie' do
    user = create_and_signin
    oven = user.ovens.first

    visit oven_path(oven)

    expect(page).to_not have_content 'Chocolate Chip'
    expect(page).to_not have_content 'Your Cookie is Ready'

    click_link_or_button 'Prepare Cookie'
    fill_in 'Fillings', with: 'Chocolate Chip'
    fill_in 'Amount', with: 1
    click_button 'Mix and bake'

    travel_back
    visit oven_path(oven)

    expect(current_path).to eq(oven_path(oven))
    expect(page).to have_content 'Chocolate Chip'
    expect(page).to have_content 'Your Cookie is Ready'

    click_button 'Retrieve Cookie'
    expect(page).to_not have_content 'Chocolate Chip'
    expect(page).to_not have_content 'Your Cookie is Ready'

    visit root_path
    within '.store-inventory' do
      expect(page).to have_content '1 Cookie'
    end
  end

  scenario 'Cooking a single cookie with no fillings' do
    user = create_and_signin
    oven = user.ovens.first

    visit oven_path(oven)

    expect(page).to_not have_content 'no fillings'
    expect(page).to_not have_content 'Your Cookie is Ready'
    
    
    click_link_or_button 'Prepare Cookie'

    fill_in 'Amount', with: 1
    click_button 'Mix and bake'

    travel_back
    visit oven_path(oven)

    expect(current_path).to eq(oven_path(oven))
    expect(page).to have_content 'no fillings'
    expect(page).to have_content 'Your Cookie is Ready'

    click_button 'Retrieve Cookie'
    expect(page).to_not have_content 'no fillings'
    expect(page).to_not have_content 'Your Cookie is Ready'

    visit root_path
    within '.store-inventory' do
      expect(page).to have_content '1 Cookie'
    end
  end

  scenario 'When an oven is baking a cookie' do
    user = create_and_signin
    oven = user.ovens.first

    oven = FactoryGirl.create(:oven, user: user)
    visit oven_path(oven)

    click_link_or_button 'Prepare Cookie'
    fill_in 'Fillings', with: 'Chocolate Chip'
    fill_in 'Amount', with: 1
    click_button 'Mix and bake'

    travel_to  @time - 2.minutes 
    visit oven_path(oven)

    expect(page).to have_content 'Status: Baking'
    expect(current_path).to eq(oven_path(oven))
    expect(page).to_not have_button 'Mix and bake'
  end

  scenario 'When cookies are ready' do
    user = create_and_signin
    oven = user.ovens.first

    oven = FactoryGirl.create(:oven, user: user)
    visit oven_path(oven)

    click_link_or_button 'Prepare Cookie'
    fill_in 'Fillings', with: 'Chocolate Chip'
    fill_in 'Amount', with: 1
    click_button 'Mix and bake'

    travel_back
    visit oven_path(oven)

    expect(page).to have_content 'Your Cookie is Ready'
    expect(current_path).to eq(oven_path(oven))
    expect(page).to_not have_button 'Mix and bake'
  end

  scenario 'Baking multiple cookies' do
    user = create_and_signin
    oven = user.ovens.first

    oven = FactoryGirl.create(:oven, user: user)
    visit oven_path(oven)

    click_link_or_button 'Prepare Cookie'
    fill_in 'Fillings', with: 'Chocolate Chip'
    fill_in 'Amount', with: 3
    click_button 'Mix and bake'

    travel_back
    visit oven_path(oven)

    click_button 'Retrieve Cookie'

    visit root_path
    within '.store-inventory' do
      expect(page).to have_content '3 Cookies'
    end
  end
end
