require 'test_helper'

class PatrolTest < ActiveSupport::TestCase

  test 'patrol can be saved' do
    patrol = Patrol.new(name: 'patrol name')
    assert patrol.save
  end

  test 'patrol requires name' do
    patrol = Patrol.new
    assert_not patrol.save
  end

  test 'patrol name requirements' do
    patrol = Patrol.new(name: 'abc')
    assert_not patrol.save
    patrol = Patrol.new(name: 'a'*51)
    assert_not patrol.save
  end

  test 'scouts belong to patrol' do
    patrol = Patrol.new(name: 'patrol name')
    assert patrol.respond_to?(:scouts)
  end

end
