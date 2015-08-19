class Book
  attr_reader(:title, :author, :genre, :id)

  define_method(:initialize) do |attributes|
    @title = attributes.fetch(:title)
    @author = attributes.fetch(:author)
    @genre = attributes.fetch(:genre)
  end

  define_singleton_method(:all) do
    returned_books = DB.exec("SELECT * FROM books;")
    books = []
    returned_books.each() do |book|
      title = book.fetch('title')
      author_id = book.fetch("author_id").to_i()
      books.push(Book.new({:title => title, :author => author, :genre => genre, :id => id}))
    end
    books
  end

  define_method(:==) do |another_book|
    self.title().==(another_book.title()).&(self.author().==(another_book.author())).&(self.genre().==(another_book.genre())).&(self.id().==(another_book.id()))
  end


end
