require 'rails_helper'

RSpec.describe "scout_requirements/edit", type: :view do
  before(:each) do
    @scout_requirement = assign(:scout_requirement, ScoutRequirement.create!())
  end

  it "renders the edit scout_requirement form" do
    render

    assert_select "form[action=?][method=?]", scout_requirement_path(@scout_requirement), "post" do
    end
  end
end
