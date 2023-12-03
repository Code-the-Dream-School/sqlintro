require "sqlite3"
require "pp"
require "tty-prompt"

db = SQLite3::Database.new "test.db"
db.execute("PRAGMA foreign_keys=ON")

tables = db.execute("SELECT name FROM sqlite_schema WHERE type='table' ORDER BY 'name'");
puts "The tables in this database are:"
puts tables
puts "Enter SQL statements below, ending with a semicolon.  Or, type Ctrl-C to quit."
prompt = TTY::Prompt.new

sql = ""
loop do
  begin 
    if sql == ""
      line_prompt="SQL ==>"
    else
      line_prompt = ""
    end
    answer = prompt.ask line_prompt
  rescue TTY::Reader::InputInterrupt
    puts "\nBye for now!"
    break
  end
  if answer
    sql += answer
  end
  if sql.include? ";"
    begin
      pp db.execute2(sql)
    rescue SQLite3::Exception => e 
      puts e.message
    end
    sql = ""
  else
    sql += "\n"
  end
end
