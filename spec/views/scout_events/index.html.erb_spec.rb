require 'rails_helper'

RSpec.describe "scout_events/index", type: :view do
  before(:each) do
    assign(:scout_events, [
      ScoutEvent.create!(
        :scout_id => 2,
        :event_id => 3,
        :notes => "Notes"
      ),
      ScoutEvent.create!(
        :scout_id => 2,
        :event_id => 3,
        :notes => "Notes"
      )
    ])
  end

  it "renders a list of scout_events" do
    render
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
    assert_select "tr>td", :text => "Notes".to_s, :count => 2
  end
end
