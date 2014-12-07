# useless_spec.rb

require './useless'

describe Useless do
  before :all do

    testdata = [
      {
        "field1" => "value1",
        "field2" => "value2"
      },{
        "field1" => "value1",
        "field3" => "value3"
      },{
        "field1" => "value4",
        "field3" => "value3"
      }
    ]

    @db = Useless.new(testdata)
  end

  describe "#find" do
    it "should return entries that match the conditions" do
      expected_data = [{
        "field1" => "value1",
        "field2" => "value2"
      },{
        "field1" => "value1",
        "field3" => "value3"
      }]
      expect(@db.find({"field1" => "value1"})).to match_array(expected_data)
    end

    it "should return only the specified fields" do
      expected_data = [{
        "field1" => "value1"
      },{
        "field1" => "value1"
      },{
        "field1" => "value4"
      }]

      expect(@db.find({},["field1"])).to match_array(expected_data)
    end

    it "should return entries that match conditions and only have the specified fields" do
      expected_data = [{"field3" => "value3" },{ "field3" => "value3" }]

      expect(@db.find({"field3" => "value3"},["field3"])).to match_array(expected_data)
    end

    it "should logical 'and' when multiple conditions are specified" do
      expected_data = [{ "field1" => "value1", "field2" => "value2"}]

      expect(@db.find({"field1" => "value1", "field2" => "value2"})).to match_array(expected_data)
    end
  end

  describe "#count" do
    xit "should count the number of entries with the specified field"
  end

  describe "#min" do
    xit "should return the minimum value of the field"

    xit "should return nil if there is no field with that value"
  end
end
