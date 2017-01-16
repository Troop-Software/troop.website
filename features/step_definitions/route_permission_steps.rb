And(/^I visit (.*)$/) do |page|
  @page = page
  begin
  visit @page
    ap page
  rescue ActiveRecord::RecordNotFound, ActionController::InvalidCrossOriginRequest, ActionController::UnknownFormat => error
    ap error
    end
end

Then(/^the response code should be (.*)$/) do |allowed|
  case allowed
    when 'true'
      expect(page.current_path).to eq(@page)
    when 'false'
      if @email.blank?
        expect(page.current_path).to eq('/users/sign_in')
      else
        expect(page.current_path).to eq('/')
      end
    else
      fail
  end
end
