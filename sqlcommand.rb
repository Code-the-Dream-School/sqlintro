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
      result_strings = db.execute2(sql).map do |row|
        row.map { _1.nil? ? "NULL" : _1.to_s } # nil.to_s is the empty string, but SQL clients typically display NULL
      end

      column_widths = Array.new(result_strings.first.length) { 0 } # Assume at least one row exists (column headings)
      result_strings.each do |row|
        row.each_with_index { |str, i| column_widths[i] = [column_widths[i], str.length].max }
      end

      result_strings.insert(1, column_widths.map { '-' * _1 }) # Separate the headings

      result_strings.each do |row|
        puts row.each_with_index.map { |str, i| str.ljust(column_widths[i]) }.join(" | ")
      end
    rescue SQLite3::Exception => e 
      puts e.message
    end
    sql = ""
  else
    sql += "\n"
  end
end
