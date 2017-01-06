require 'rails_helper'

RSpec.describe "event_locations/new", type: :view do
  before(:each) do
    assign(:event_location, EventLocation.new(
      :line1 => "MyString",
      :line2 => "MyString",
      :city => "MyString",
      :state => "MyString",
      :zip => "MyString",
      :type => 1,
      :latitude => 1.5,
      :longitude => 1.5
    ))
  end

  it "renders new event_location form" do
    render

    assert_select "form[action=?][method=?]", event_locations_path, "post" do

      assert_select "input#event_location_line1[name=?]", "event_location[line1]"

      assert_select "input#event_location_line2[name=?]", "event_location[line2]"

      assert_select "input#event_location_city[name=?]", "event_location[city]"

      assert_select "input#event_location_state[name=?]", "event_location[state]"

      assert_select "input#event_location_zip[name=?]", "event_location[zip]"

      assert_select "input#event_location_type[name=?]", "event_location[type]"

      assert_select "input#event_location_latitude[name=?]", "event_location[latitude]"

      assert_select "input#event_location_longitude[name=?]", "event_location[longitude]"
    end
  end
end
