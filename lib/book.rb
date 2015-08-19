class Book
  attr_reader(:title, :author, :genre, :id)

  define_method(:initialize) do |attributes|
    @title = attributes.fetch(:title)
    @author = attributes.fetch(:author)
    @genre = attributes.fetch(:genre)
    @id = attributes.fetch(:id)
  end

  define_singleton_method(:all) do
    returned_books = DB.exec("SELECT * FROM books;")
    books = []
    returned_books.each() do |book|
      title = book.fetch('title')
      author = book.fetch('author')
      genre = book.fetch('genre')
      id = book.fetch("id").to_i()
      books.push(Book.new({:title => title, :author => author, :genre => genre, :id => id}))
    end
    books
  end

  define_method(:==) do |another_book|
    self.title().==(another_book.title()).&(self.author().==(another_book.author())).&(self.genre().==(another_book.genre())).&(self.id().==(another_book.id()))
  end

  define_method(:save) do
    result = DB.exec("INSERT INTO books (title, author, genre) VALUES ('#{@title}', '#{@author}','#{@genre}')RETURNING id;")
    @id = result.first().fetch("id").to_i()
  end

  define_singleton_method(:find) do |id|
    found_book = nil
    Book.all().each() do |book|
      if book.id().==(id)
        found_book = book
      end
    end
    found_book
  end

  define_method(:update) do |attributes|
    @title = attributes.fetch(:title)
    @author = attributes.fetch(:author)
    @genre = attributes.fetch(:genre)
    @id = self.id()
    DB.exec("UPDATE books SET title = '#{@title}' WHERE id = #{@id};")
    DB.exec("UPDATE books SET author = '#{@author}' WHERE id = #{@id};")
    DB.exec("UPDATE books SET genre = '#{@genre}' WHERE id = #{@id};")
  end

  define_method(:delete) do
    DB.exec("DELETE FROM books WHERE id = #{self.id()};")
  end

end
