module ObjectDeepDiff
  class HashDeepDiff

    def initialize(left_hash, right_hash)
      @left_hash = left_hash
      @right_hash = right_hash
    end

    def call
      (@left_hash.keys + @right_hash.keys).uniq.each_with_object({}) do |key, hash|
        comp_result = comparison(@left_hash[key], @right_hash[key])
        hash[key] = comp_result if comp_result && !comp_result.empty?
      end
    end

    def comparison(left_val, right_val)
      case true
      when left_val.is_a?(Hash) && right_val.is_a?(Hash)
        self.class.new(left_val, right_val).call
      when left_val.is_a?(Array) && right_val.is_a?(Array)
        res = [left_val - right_val, right_val - left_val]
        res.all?(&:empty?) ? nil : res
      when left_val != right_val
        [left_val, right_val]
      end
    end
  end
end