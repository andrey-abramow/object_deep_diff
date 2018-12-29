require "test_helper"

class ObjectDeepHashTest < Minitest::Test

  def test_should_return_object_hash
    object = Class.new do

      def name
        'name'
      end

      def item
        Class.new do
          def item_name
            'item_name'
          end
        end.new
      end

      def array_items
        [
         Class.new do
           def nest_name
             'nest_name'
           end
         end.new
        ]
      end

    end.new


    hash = ObjectDeepDiff::ObjectHash.new(object).call do
      name

      item do
        item_name
      end

      array_items do
        nest_name
      end

    end

    expected_hash = {
      :name=>"name",
      :item=>{:item_name=>"item_name"},
      :array_items=>[{:nest_name=>"nest_name"}]
    }

    assert_equal(expected_hash, hash)
  end

end
