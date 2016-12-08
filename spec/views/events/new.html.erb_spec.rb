require 'rails_helper'

RSpec.describe "events/new", type: :view do
  before(:each) do
    assign(:event, Event.new(
      :title => "MyString",
      :description => "MyString",
      :allDay => false,
      :category => 1,
      :external_link => ""
    ))
  end

  it "renders new event form" do
    render

    assert_select "form[action=?][method=?]", events_path, "post" do

      assert_select "input#event_title[name=?]", "event[title]"

      assert_select "input#event_description[name=?]", "event[description]"

      assert_select "input#event_allDay[name=?]", "event[allDay]"

      assert_select "input#event_category[name=?]", "event[category]"

      assert_select "input#event_external_link[name=?]", "event[external_link]"
    end
  end
end
