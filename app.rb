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

get('/books/:id') do
  @book = Book.find(params.fetch('id').to_i)
  erb(:book)
end

get('/books/:id/edit') do
  @book = Book.find(params.fetch('id').to_i)
  erb(:edit_book)
end

patch('books/:id') do
  title = params.fetch('title')
  genre = params.fetch('genre')
  author = params.fetch('author')
  Binding.pry
  @book = Book.find(params.fetch("id").to_i())
  @book.update({:title => title, :author => author, :genre => genre, :id => nil})
  erb(:book)
end

delete("/books/:id") do
  @book = Book.find(params.fetch("id").to_i())
  @book.delete()
  @books = Book.all()
  erb(:book)
end
