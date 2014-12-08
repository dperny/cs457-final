require './transmogrifier'
require './useless'

trap("SIGINT") do
  puts "\nBye!"
  exit!
end

def main
  db = Useless.new(Transmogrifier.read(ARGV[0]))
  
  loop do
    print "> "
    command = STDIN.gets.chomp
    result = Transmogrifier.eval(db, command)
    STDOUT.puts Transmogrifier.print(result)
  end
end

main
