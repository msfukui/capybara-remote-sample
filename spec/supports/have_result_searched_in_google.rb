RSpec::Matchers.define :have_result_searched_in_google do |message|

  match do |page|
    expect(page).to have_content message
  end
end
