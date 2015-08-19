class Author
  attr_reader(:first_name, :last_name, :id)

  define_method(:initialize) do |attributes|
    @first_name = attributes.fetch(:first_name)
    @last_name = attributes.fetch(:last_name)
    @id = attributes.fetch(:id)
  end

  define_singleton_method(:all) do
    returned_authors = DB.exec("SELECT * FROM authors;")
    authors = []
    returned_authors.each() do |author|
      first_name = author.fetch('first_name')
      last_name = author.fetch('last_name')
      id = author.fetch("id").to_i()
      authors.push(Author.new({:first_name => first_name, :last_name => last_name, :id => id}))
    end
    authors
  end

  define_method(:==) do |another_author|
    self.first_name().==(another_author.first_name()).&(self.last_name().==(another_author.last_name())).&(self.id().==(another_author.id()))
  end

  define_method(:save) do
    result = DB.exec("INSERT INTO authors (first_name, last_name) VALUES ('#{@first_name}', '#{@last_name}') RETURNING id;")
    @id = result.first().fetch("id").to_i()
  end

  define_singleton_method(:find) do |id|
    found_author = nil
    Author.all().each() do |author|
      if author.id().==(id)
        found_author = author
      end
    end
    found_author
  end

  define_method(:update) do |attributes|
    @first_name = attributes.fetch(:first_name)
    @last_name = attributes.fetch(:last_name)
    @id = self.id()
    DB.exec("UPDATE authors SET first_name = '#{@first_name}' WHERE id = #{@id}")
    DB.exec("UPDATE authors SET last_name = '#{@last_name}' WHERE id = #{@id}")
  end

end
