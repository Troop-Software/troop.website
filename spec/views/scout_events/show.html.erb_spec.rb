require 'rails_helper'

RSpec.describe "scout_events/show", type: :view do
  before(:each) do
    @scout_event = assign(:scout_event, ScoutEvent.create!(
      :scout_id => 2,
      :event_id => 3,
      :notes => "Notes"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/2/)
    expect(rendered).to match(/3/)
    expect(rendered).to match(/Notes/)
  end
end
