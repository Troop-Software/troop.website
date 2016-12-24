require 'rails_helper'

RSpec.describe "scout_positions/index", type: :view do
  before(:each) do
    assign(:scout_positions, [
      ScoutPosition.create!(
        :scout => nil,
        :position => nil,
        :current => false
      ),
      ScoutPosition.create!(
        :scout => nil,
        :position => nil,
        :current => false
      )
    ])
  end

  it "renders a list of scout_positions" do
    render
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
  end
end
