require 'rails_helper'

RSpec.describe "scout_requirements/index", type: :view do
  before(:each) do
    assign(:scout_requirements, [
      ScoutRequirement.create!(),
      ScoutRequirement.create!()
    ])
  end

  it "renders a list of scout_requirements" do
    render
  end
end
