require 'rails_helper'

RSpec.describe "scout_trainings/index", type: :view do
  before(:each) do
    assign(:scout_trainings, [
      ScoutTraining.create!(
        :scout => nil,
        :youth_training => nil
      ),
      ScoutTraining.create!(
        :scout => nil,
        :youth_training => nil
      )
    ])
  end

  it "renders a list of scout_trainings" do
    render
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
