require 'rails_helper'

RSpec.describe "scout_trainings/new", type: :view do
  before(:each) do
    assign(:scout_training, ScoutTraining.new(
      :scout => nil,
      :youth_training => nil
    ))
  end

  it "renders new scout_training form" do
    render

    assert_select "form[action=?][method=?]", scout_trainings_path, "post" do

      assert_select "input#scout_training_scout_id[name=?]", "scout_training[scout_id]"

      assert_select "input#scout_training_youth_training_id[name=?]", "scout_training[youth_training_id]"
    end
  end
end
