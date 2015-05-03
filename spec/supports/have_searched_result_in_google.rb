RSpec::Matchers.define :have_searched_result_in_google do |message|

  match do |page|
    expect(page).to have_content message
  end
end
