require 'rails_helper'

RSpec.describe "event_locations/show", type: :view do
  before(:each) do
    @event_location = assign(:event_location, EventLocation.create!(
      :line1 => "Line1",
      :line2 => "Line2",
      :city => "City",
      :state => "State",
      :zip => "Zip",
      :type => 2,
      :latitude => 3.5,
      :longitude => 4.5
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Line1/)
    expect(rendered).to match(/Line2/)
    expect(rendered).to match(/City/)
    expect(rendered).to match(/State/)
    expect(rendered).to match(/Zip/)
    expect(rendered).to match(/2/)
    expect(rendered).to match(/3.5/)
    expect(rendered).to match(/4.5/)
  end
end
