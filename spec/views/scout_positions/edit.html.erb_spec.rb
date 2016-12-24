require 'rails_helper'

RSpec.describe "scout_positions/edit", type: :view do
  before(:each) do
    @scout_position = assign(:scout_position, ScoutPosition.create!(
      :scout => nil,
      :position => nil,
      :current => false
    ))
  end

  it "renders the edit scout_position form" do
    render

    assert_select "form[action=?][method=?]", scout_position_path(@scout_position), "post" do

      assert_select "input#scout_position_scout_id[name=?]", "scout_position[scout_id]"

      assert_select "input#scout_position_position_id[name=?]", "scout_position[position_id]"

      assert_select "input#scout_position_current[name=?]", "scout_position[current]"
    end
  end
end
