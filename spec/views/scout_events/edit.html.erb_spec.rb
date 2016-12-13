require 'rails_helper'

RSpec.describe "scout_events/edit", type: :view do
  before(:each) do
    @scout_event = assign(:scout_event, ScoutEvent.create!(
      :scout_id => 1,
      :event_id => 1,
      :notes => "MyString"
    ))
  end

  it "renders the edit scout_event form" do
    render

    assert_select "form[action=?][method=?]", scout_event_path(@scout_event), "post" do

      assert_select "input#scout_event_scout_id[name=?]", "scout_event[scout_id]"

      assert_select "input#scout_event_event_id[name=?]", "scout_event[event_id]"

      assert_select "input#scout_event_notes[name=?]", "scout_event[notes]"
    end
  end
end
