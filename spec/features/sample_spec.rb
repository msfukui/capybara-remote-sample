require 'spec_helper'

describe 'Access to Google' do

  before do
    visit '/'
  end

  it { expect(page).to have_content('Google') }
end
