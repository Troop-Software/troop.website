require 'rails_helper'

RSpec.describe "scout_trainings/edit", type: :view do
  before(:each) do
    @scout_training = assign(:scout_training, ScoutTraining.create!(
      :scout => nil,
      :youth_training => nil
    ))
  end

  it "renders the edit scout_training form" do
    render

    assert_select "form[action=?][method=?]", scout_training_path(@scout_training), "post" do

      assert_select "input#scout_training_scout_id[name=?]", "scout_training[scout_id]"

      assert_select "input#scout_training_youth_training_id[name=?]", "scout_training[youth_training_id]"
    end
  end
end
