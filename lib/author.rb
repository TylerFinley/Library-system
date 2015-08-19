class Author
  attr_reader(:first_name, :last_name)

  define_method(:initialize) do |attributes|
    @first_name = attributes.fetch(:first_name)
    @last_name = attributes.fetch(:last_name)
  end

  define_singleton_method(:all) do
    returned_authors = DB.exec("SELECT * FROM authors;")
    authors = []
    returned_authors.each() do |author|
      first_name = author.fetch('first_name')
      last_name = author.fetch('last_name')
      id = author.fetch("id").to_i()
      authors.push(Author.new({:title => title, :author => author, :genre => genre, :id => id}))
    end
    authors
  end

  define_method(:==) do |another_author|
    self.first_name().==(another_author.first_name()).&(self.last_name().==(another_author.last_name()))
  end

end
