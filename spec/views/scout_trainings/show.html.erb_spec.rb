require 'rails_helper'

RSpec.describe "scout_trainings/show", type: :view do
  before(:each) do
    @scout_training = assign(:scout_training, ScoutTraining.create!(
      :scout => nil,
      :youth_training => nil
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(//)
  end
end
