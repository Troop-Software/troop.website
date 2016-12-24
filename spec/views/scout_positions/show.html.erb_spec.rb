require 'rails_helper'

RSpec.describe "scout_positions/show", type: :view do
  before(:each) do
    @scout_position = assign(:scout_position, ScoutPosition.create!(
      :scout => nil,
      :position => nil,
      :current => false
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(/false/)
  end
end
