require "object_deep_diff/version"
require 'object_deep_diff/object_hash'
require 'object_deep_diff/hash_deep_diff'

module ObjectDeepDiff
  class ObjectDiff

    def initialize(&config)
      @config = config
    end

    def left_obj=(obj)
      raise 'config required!' if (!@config)
      @left_hash = ObjectHash.new(obj).call(&@config)
    end

    def right_obj=(obj)
      raise 'config required!' if (!@config)
      @right_hash = ObjectHash.new(obj).call(&@config)
    end

    def call
      raise 'left_obj required!' if (!@left_hash)
      raise 'right_obj required!' if (!@right_hash)
      HashDeepDiff.new(@left_hash, @right_hash).call
    end

  end
end
