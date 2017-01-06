require 'rails_helper'

RSpec.describe "event_locations/index", type: :view do
  before(:each) do
    assign(:event_locations, [
      EventLocation.create!(
        :line1 => "Line1",
        :line2 => "Line2",
        :city => "City",
        :state => "State",
        :zip => "Zip",
        :type => 2,
        :latitude => 3.5,
        :longitude => 4.5
      ),
      EventLocation.create!(
        :line1 => "Line1",
        :line2 => "Line2",
        :city => "City",
        :state => "State",
        :zip => "Zip",
        :type => 2,
        :latitude => 3.5,
        :longitude => 4.5
      )
    ])
  end

  it "renders a list of event_locations" do
    render
    assert_select "tr>td", :text => "Line1".to_s, :count => 2
    assert_select "tr>td", :text => "Line2".to_s, :count => 2
    assert_select "tr>td", :text => "City".to_s, :count => 2
    assert_select "tr>td", :text => "State".to_s, :count => 2
    assert_select "tr>td", :text => "Zip".to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => 3.5.to_s, :count => 2
    assert_select "tr>td", :text => 4.5.to_s, :count => 2
  end
end
