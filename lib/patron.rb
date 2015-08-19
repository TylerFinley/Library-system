class Patron
  attr_reader(:name, :books_checkedout, :id)

  define_method(:initialize) do |attributes|
    @name = attributes.fetch(:name)
    @books_checkedout = attributes.fetch(:books_checkedout)
    @id = attributes.fetch(:id)
  end

  define_singleton_method(:all) do
    returned_authors = DB.exec("SELECT * FROM patrons;")
    patrons = []
    returned_authors.each() do |author|
      name = author.fetch('name')
      books_checkedout = author.fetch('books_checkedout').to_i()
      id = author.fetch("id").to_i()
      patrons.push(Patron.new({:name => name, :books_checkedout => books_checkedout, :id => id}))
    end
    patrons
  end

  define_method(:==) do |another_patron|
    self.name().==(another_patron.name()).&(self.books_checkedout().==(another_patron.books_checkedout())).&(self.id().==(another_patron.id()))
  end

  define_method(:save) do
    result = DB.exec("INSERT INTO patrons (name, books_checkedout) VALUES ('#{@name}', #{@books_checkedout}) RETURNING id;")
    @id = result.first().fetch("id").to_i()
  end

  define_singleton_method(:find) do |id|
    found_author = nil
    Patron.all().each() do |author|
      if author.id().==(id)
        found_author = author
      end
    end
    found_author
  end

  define_method(:update) do |attributes|
    @name = attributes.fetch(:name)
    @books_checkedout = attributes.fetch(:books_checkedout).to_i()
    @id = self.id().to_i()
    DB.exec("UPDATE patrons SET name = '#{@name}' WHERE id = #{@id}")
    DB.exec("UPDATE patrons SET books_checkedout = #{@books_checkedout} WHERE id = #{@id}")
  end

  define_method(:delete) do
    DB.exec("DELETE FROM patrons WHERE id = #{self.id()};")
  end

end
