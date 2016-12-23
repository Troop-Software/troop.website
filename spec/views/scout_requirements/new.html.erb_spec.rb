require 'rails_helper'

RSpec.describe "scout_requirements/new", type: :view do
  before(:each) do
    assign(:scout_requirement, ScoutRequirement.new())
  end

  it "renders new scout_requirement form" do
    render

    assert_select "form[action=?][method=?]", scout_requirements_path, "post" do
    end
  end
end
