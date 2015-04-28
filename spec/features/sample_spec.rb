require 'spec_helper'

describe 'BIGLOBE' do

  before do
    visit '/'
  end

  it { expect(page).to have_content('BIGLOBE') }
end
