# transmogrifier.rb
require './useless'
require 'pp'

class Transmogrifier

  def initialize(filename)
    @db = Useless.new self.read(filename)
  end

  def self.read(filename)
    contents = []
    id = 1
    File.open(filename) do |file|
      file.readlines.each do |line|
        record = {}
        record["ID"] = id.to_s
        line.split(" ").each_slice(2) do |field|
          record[field[0].chomp(":")] = field[1]
        end
        id += 1
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
    output1 = raw_args.gsub(/[\{]|[\}]/,"").split(",").each { |s| s.strip! }
    output = []
    output1.each { |o| unless o.empty? then output << o end }
    output
  end

  def self.eval(db, command)
    command = command.split(".")[2]
    method = command.split("(")[0]
    args = command.split("(")[1].chomp(")")
    rval = if method == "find"
      args = args.split("},")
      db.find(self.make_arg_hash(args[0]),self.make_arg_array(args[1]))
    elsif method == "count"
      db.count(args)
    elsif method == "min"
      db.min(args)
    elsif method == "cartprod"
      args = args.split(",").each { |s| s.strip! }
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
