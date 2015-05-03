require 'spec_helper'

describe 'Access to Google' do

  before do
    visit '/'
  end

  it { expect(page).to have_content 'Google' }
end

describe 'Search "Capybara" in Google' do

  before do
    visit '/'
  end

  specify do
    fill_in_search_google 'Capybara'
    click_button 'Google 検索'

    expect(page).to have_searched_result_in_google 'jnicklas/capybara'
  end
end
