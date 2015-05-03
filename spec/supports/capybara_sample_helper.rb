module CapybaraSampleHelper

  def fill_in_search_in_google( str )
    within '#searchform' do
      fill_in 'q', with: str
    end
  end

  def click_search_button_in_google
    normal  = 'Google 検索'
    suggest = '検索'

    if has_selector?('div.jsb')
      within 'div.jsb' do
        click_button(normal)
      end
    else
      within '#sblsbb' do
        click_button(suggest)
      end
    end
  end
end

include CapybaraSampleHelper
