module ObjectDeepDiff
  class ObjectValue

    def initialize(object)
      @object = object
    end

    def call(name, &block)
      prop_value = @object.public_send(name)
      if (prop_value.respond_to? :map)
        prop_value.map { |item| ObjectHash.new(item).call(&block) }
      else
        if block_given?
          return nil if prop_value.nil?
          ObjectHash.new(prop_value).call(&block)
        else
          prop_value
        end
      end
    end

  end

  class ObjectHash

    def initialize(object)
      @object = object

      @hash = {}

      @object_value = ObjectValue.new(@object)
    end

    def call(&block)
      self.instance_exec(&block)
      @hash
    end

    def method_missing(m, *args, &block)
      prop_value = @object_value.call(m, &block)
      if (prop_value)
        @hash[m] = prop_value
      end
    end

  end
end