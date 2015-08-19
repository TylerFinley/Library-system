require("sinatra")
require("sinatra/reloader")
also_reload("lib/**/*.rb")
require("./lib/patron")
require('./lib/book')
require('./lib/author')
require("pg")
require("pry")

DB = PG.connect({:dbname => "library_test"})

get('/') do
  erb(:index)
end

####################  BOOKS  #######################

get('/book/new') do
  erb(:book_form)
end

post('/books') do
  title = params.fetch('title')
  genre = params.fetch('genre')
  author = params.fetch('author')
  book = Book.new({:title => title, :author => author, :genre => genre, :id => nil})
  book.save()
  @books = Book.all()
  erb(:books)
end

get('/books') do
  @books = Book.all()
  erb(:books)
end

get('/book/:id') do
  @book = Book.find(params.fetch('id').to_i)
  erb(:book)
end

get('/book/:id/edit') do
  @book = Book.find(params.fetch('id').to_i)
  erb(:edit_book)
end

patch('/books/:id') do
  title = params.fetch('title')
  genre = params.fetch('genre')
  author = params.fetch('author')
  @book = Book.find(params.fetch("id").to_i())
  @book.update({:title => title, :author => author, :genre => genre, :id => nil})
  erb(:index)
end

delete("/books/:id") do
  @book = Book.find(params.fetch("id").to_i())
  @book.delete()
  @books = Book.all()
  erb(:books)
end



####################  PATRONS  #######################

get('/patrons') do
  @patrons = Patron.all()
  erb(:patrons)
end

post('/patrons') do
  name = params.fetch('name')
  books_checkedout = params.fetch('books').to_i()
  patron = Patron.new({:name => name, :books_checkedout => books_checkedout, :id => nil})
  patron.save()
  binding.pry
  @patrons = Patron.all()
  erb(:patrons)
end

get('/patrons/:id') do
  @book = Patron.find(params.fetch('id').to_i)
  erb(:patron)
end
