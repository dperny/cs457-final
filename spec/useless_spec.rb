# useless_spec.rb

require './useless'

describe Useless do
  before :all do

    testdata = [
      {
        "field1" => "1",
        "field2" => "2"
      },{
        "field1" => "1",
        "field3" => "3"
      },{
        "field1" => "4",
        "field3" => "3"
      }
    ]

    @db = Useless.new(testdata)
  end

  describe "#find" do
    it "should return entries that match the conditions" do
      expected_data = [{
        "field1" => "1",
        "field2" => "2"
      },{
        "field1" => "1",
        "field3" => "3"
      }]
      expect(@db.find({"field1" => "1"})).to match_array(expected_data)
    end

    it "should return only the specified fields" do
      expected_data = [{
        "field1" => "1"
      },{
        "field1" => "1"
      },{
        "field1" => "4"
      }]

      expect(@db.find({},["field1"])).to match_array(expected_data)
    end

    it "should return entries that match conditions and only have the specified fields" do
      expected_data = [{"field3" => "3" },{ "field3" => "3" }]

      expect(@db.find({"field3" => "3"},["field3"])).to match_array(expected_data)
    end

    it "should logical 'and' when multiple conditions are specified" do
      expected_data = [{ "field1" => "1", "field2" => "2"}]

      expect(@db.find({"field1" => "1", "field2" => "2"})).to match_array(expected_data)
    end
  end

  describe "#count" do
    it "should count the number of entries with the specified field" do
      expect(@db.count("field1")).to be 3
      expect(@db.count("field2")).to be 1
      expect(@db.count("field4")).to be 0
    end
  end

  describe "#min" do
    it "should return the minimum value of the field" do
      expect(@db.min("field1")).to be 1
      expect(@db.min("field2")).to be 2
    end

    it "should return nil if there is no field with that value" do
      expect(@db.min("field4")).to be nil
    end
  end
end
