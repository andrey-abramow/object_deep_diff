require "test_helper"

class HashDeepDiffTest < Minitest::Test

  def test_simple_props
    left_hash = {
      changed: 'name1',
      not_changed: 'not_changed',
      only_left: 'only_left'
    }

    right_hash = {
      changed: 'name2',
      not_changed: 'not_changed',
      only_right: 'only_right'
    }

    expected_hash = {
      changed: ['name1', 'name2'],
      only_left: ['only_left', nil],
      only_right: [nil, 'only_right']
    }

    result = ObjectDeepDiff::HashDeepDiff.new(left_hash, right_hash).call
    assert_equal(expected_hash, result)
  end

  def test_array_of_hashes
    left_hash = {
      items: [
        { value: 1 },
        { value: 2 },
        { value: 3 },
        { value: 4 }
      ]
    }

    right_hash = {
      items: [
        { value: 2 },
        { value: 3 },
        { value: 4 },
        { value: 5 }
      ]
    }

    expected_hash = {
      items: [[{ value: 1}], [{ value: 5}]]
    }

    result = ObjectDeepDiff::HashDeepDiff.new(left_hash, right_hash).call
    assert_equal(expected_hash, result)

    left_hash = {
      value: 1,
      items: [{value: 1, changed: '1'}]
    }

    right_hash = {
      items: [
        { value: 2 },
        { value: 3 },
        { value: 4 },
        { value: 5 }
      ]
    }

    expected_hash = {
      items: [[{ value: 1}], [{ value: 5}]]
    }

  end

end
