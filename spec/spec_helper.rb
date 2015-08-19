require("rspec")
require("pg")
require("author")
require("book")
require("pry")
require("launchy")


DB = PG.connect({:dbname => "library_test"})

RSpec.configure do |config|
  config.after(:each) do
    DB.exec("DELETE FROM books *;")
    DB.exec("DELETE FROM authors *;")
  end
end
