require 'spec_helper'

describe 'Access to Google' do

  before do
    visit '/'
  end

  it { expect(page).to have_content('Google') }
end

describe 'Search "Capybara" in Google' do

  before do
    visit '/'
  end

  it 'Google で Capybara の検索結果を取得できる。' do
    fill_in_search_google 'Capybara'
    click_button 'Google 検索'

    within '#search' do
      expect(page).to have_content('jnicklas/capybara')
    end
  end
end
