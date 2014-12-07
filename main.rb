require './useless.rb'
require 'json'

trap("SIGINT") do
  puts "\nBye!"
  exit!
end

def transmogrify(filename)
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

def main

  db = Useless.new(transmogrify(args[1]))
  
  loop do
    print "> "
    command = gets.chomp
    db.eval command
  end
end

main
