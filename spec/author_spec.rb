require('spec_helper')

describe(Author) do
  describe('.all') do
    it('return an empty array at first') do
      expect(Author.all()).to(eq([]))
    end
  end

  describe(".==") do
    it('is the same first name if it has the same first name') do
      author1 = Author.new({:first_name => "JK", :last_name => "Rowling", :id => nil})
      author2 = Author.new({:first_name => "JK", :last_name => "Rowling", :id => nil})
      expect(author1).to(eq(author2))
    end
  end


  describe('#save') do
    it('lets you save the author to a book') do
      author1 = Author.new({:first_name => "JK", :last_name => "Rowling", :id => nil})
      author1.save
      expect(Author.all()).to(eq([author1]))
    end
  end

  describe('.find') do
    it('lets you find an author by the id') do
      author1 = Author.new({:first_name => "JK", :last_name => "Rowling", :id => nil})
      author1.save()
      author2 = Author.new({:first_name => "JK", :last_name => "Rowling", :id => nil})
      author2.save()
      expect(Author.find(author1.id())).to(eq(author1))
    end
  end

  describe('#update') do
    it('lets you update authors in the database') do
      author = Author.new({:first_name => "JK", :last_name => "Rowling", :id => nil})
      author.save()
      author.update({:first_name => "JRR", :last_name => "Tolkien"})
      expect(author.first_name()).to(eq('JRR'))
      expect(author.last_name()).to(eq('Tolkien'))
    end
  end


end
