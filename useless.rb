# useless.rb

# A useless database adapter, which works on an array of hashes and lets you
# query it like a NoSQL database
class Useless
  # Creates a new Useless adapter for the object passed in
  #
  # @param db [Array<Hash{String,String}>]
  # return [Useless] a new useless adapter
  def initialize(db)
    @store = db
  end

  # Finds entries that satisfy the conditions, and returns the specified fields
  #
  # @param conditions [Hash{String, String}] the equality conditions to check for
  # @param fields [Array<String>] the fields to return
  # @return [Array<Hash>] the entries satisifying the conditions with the specified fields
  def find(conditions, fields = nil)
    output = []
    @store.each do |entry|
      if entry.to_set.superset? conditions.to_set
        output << if fields then entry.select { |k,v| fields.include?(k) } else entry end
      end
    end
    output
  end

  def count(field)

  end
end
