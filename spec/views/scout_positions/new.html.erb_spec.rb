require 'rails_helper'

RSpec.describe "scout_positions/new", type: :view do
  before(:each) do
    assign(:scout_position, ScoutPosition.new(
      :scout => nil,
      :position => nil,
      :current => false
    ))
  end

  it "renders new scout_position form" do
    render

    assert_select "form[action=?][method=?]", scout_positions_path, "post" do

      assert_select "input#scout_position_scout_id[name=?]", "scout_position[scout_id]"

      assert_select "input#scout_position_position_id[name=?]", "scout_position[position_id]"

      assert_select "input#scout_position_current[name=?]", "scout_position[current]"
    end
  end
end
