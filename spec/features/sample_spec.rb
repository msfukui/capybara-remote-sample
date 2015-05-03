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
    fill_in_search_in_google 'Capybara'
    click_search_button_in_google

    expect(page).to have_result_searched_in_google 'jnicklas/capybara'
  end
end
