# transmogrifier.rb
require './useless'

class Transmogrifier

  def initialize(filename)
    @db = Useless.new self.read(filename)
  end

  def self.read(filename)
    contents = []
    File.open(filename) do |file|
      file.readlines.each do |line|
        record = {}
        line.split(" ").each_slice(2) do |field|
          record[field[0].chomp(":")] = field[1]
        end
        contents << record
      end
    end
    contents
  end

  def self.make_arg_hash(raw_args)
    output = {}
    raw_args.gsub(/\s+/, "").gsub(/[\{]|[\}]/,"").split(",").each do |pair|
      pair = pair.split("=")
      output[pair[0]] = pair[1]
    end
    output
  end

  def self.make_arg_array(raw_args)
    output = raw_args.gsub(/[\{]|[\}]/,"").split(",").each { |s| s.strip! }
  end

  def self.eval(db, command)
    command = command.split(".")[2]
    method = command.split("(")[0]
    args = command.split("(")[1].chomp(")").split(",")
    rval = if method == "find"
      db.find(self.make_arg_hash(args[0]),self.make_arg_array(args[1]))
    elsif method == "count"
      db.count(args[0])
    elsif method == "min"
      db.min(args[0])
    elsif method == "cartprod"
      db.cartprod(args[0],args[1])
    else
      [{}]
    end
    rval
  end

  # doesn't actually print, it actually just returns a string
  def self.print(result)
    unless result.is_a?(Array) then return result.to_s end
    out = ""
    result.each do |entry|
      entry.each do |k,v|
        out = out + k + ": " + v + " "
      end
      out = out + "\n"
    end
    out
  end
end
