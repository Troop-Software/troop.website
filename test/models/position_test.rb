require 'test_helper'

class PositionTest < ActiveSupport::TestCase
  test 'position can be saved' do
    position = Position.new(name: 'position name')
    assert position.save
  end

  test 'position requires name' do
    position = Position.new
    assert_not position.save
  end

  test 'position name requirements' do
    position = Position.new(name: 'abc')
    assert_not position.save
    position = Position.new(name: 'a'*51)
    assert_not position.save
  end

  test 'scouts belong to position' do
    position = Position.new(name: 'position name')
    assert position.respond_to?(:scouts)
  end

  test 'position name is unique' do
    position1 = Position.new(name: 'position name')
    position2 = Position.new(name: 'Position Name')
    assert position1.save
    assert_not position2.save
  end
end
