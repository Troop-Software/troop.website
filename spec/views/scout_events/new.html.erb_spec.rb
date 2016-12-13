require 'rails_helper'

RSpec.describe "scout_events/new", type: :view do
  before(:each) do
    assign(:scout_event, ScoutEvent.new(
      :scout_id => 1,
      :event_id => 1,
      :notes => "MyString"
    ))
  end

  it "renders new scout_event form" do
    render

    assert_select "form[action=?][method=?]", scout_events_path, "post" do

      assert_select "input#scout_event_scout_id[name=?]", "scout_event[scout_id]"

      assert_select "input#scout_event_event_id[name=?]", "scout_event[event_id]"

      assert_select "input#scout_event_notes[name=?]", "scout_event[notes]"
    end
  end
end
