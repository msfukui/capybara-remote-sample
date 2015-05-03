module CapybaraFillInSampleHelper

  def fill_in_search_google( str )
    within '#searchform' do
      fill_in 'q', with: str
    end
  end
end

include CapybaraFillInSampleHelper
