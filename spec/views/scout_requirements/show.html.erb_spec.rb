require 'rails_helper'

RSpec.describe "scout_requirements/show", type: :view do
  before(:each) do
    @scout_requirement = assign(:scout_requirement, ScoutRequirement.create!())
  end

  it "renders attributes in <p>" do
    render
  end
end
