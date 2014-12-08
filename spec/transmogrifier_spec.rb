# transmogrifier_spec.rb

require './transmogrifier'

describe Transmogrifier do
  describe ".print" do
    it "should output data in NoSQL format" do
      testdata = [{"one" => "1", "two" => "2"},{"three" => "3", "four" => "4"}]
      expected = "one: 1 two: 2 \nthree: 3 four: 4 \n"

      expect(Transmogrifier.print(testdata)).to eql(expected)
    end
  end
  
  describe ".make_arg_hash" do
    it "should turn find args into a hash" do
      test = "{one=1,two = 2}"
      expected = {"one" => "1", "two" => "2"}
      expect(Transmogrifier.make_arg_hash(test)).to eql(expected)
    end
  end

  describe ".make_arg_array" do
    it "should turn NoSQL args into an array" do
      expect(Transmogrifier.make_arg_array("{one, two}")).to match_array(["one","two"])
    end
  end
end
