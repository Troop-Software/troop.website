require 'rails_helper'

RSpec.describe "events/edit", type: :view do
  before(:each) do
    @event = assign(:event, Event.create!(
      :title => "MyString",
      :description => "MyString",
      :allDay => false,
      :category => 1,
      :external_link => ""
    ))
  end

  it "renders the edit event form" do
    render

    assert_select "form[action=?][method=?]", event_path(@event), "post" do

      assert_select "input#event_title[name=?]", "event[title]"

      assert_select "input#event_description[name=?]", "event[description]"

      assert_select "input#event_allDay[name=?]", "event[allDay]"

      assert_select "input#event_category[name=?]", "event[category]"

      assert_select "input#event_external_link[name=?]", "event[external_link]"
    end
  end
end
