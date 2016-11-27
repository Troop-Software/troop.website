require 'test_helper'

class RankTest < ActiveSupport::TestCase
  test 'rank can be saved' do
    rank = Rank.new(name: 'rank name')
    assert rank.save
  end

  test 'rank requires name' do
    rank = Rank.new
    assert_not rank.save
  end

  test 'rank name requirements' do
    rank = Rank.new(name: 'ab')
    assert_not rank.save
    rank = Rank.new(name: 'a'*31)
    assert_not rank.save
  end

  test 'scouts belong to rank' do
    rank = Rank.new(name: 'rank name')
    assert rank.respond_to?(:scouts)
  end
end
