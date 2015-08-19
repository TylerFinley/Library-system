require('spec_helper')

describe(Patron) do
  describe('.all') do
    it('return an empty array at first') do
      expect(Patron.all()).to(eq([]))
    end
  end

  describe(".==") do
    it('is the same first name if it has the same first name') do
      author1 = Patron.new({:name => "Craig", :books_checkedout => 1, :id => nil})
      author2 = Patron.new({:name => "Craig", :books_checkedout => 1, :id => nil})
      expect(author1).to(eq(author2))
    end
  end


  describe('#save') do
    it('lets you save the author to a book') do
      author1 = Patron.new({:name => "Craig", :books_checkedout => 1, :id => nil})
      author1.save
      expect(Patron.all()).to(eq([author1]))
    end
  end

  describe('.find') do
    it('lets you find an author by the id') do
      author1 = Patron.new({:name => "Craig", :books_checkedout => 1, :id => nil})
      author1.save()
      author2 = Patron.new({:name => "Craig", :books_checkedout => 1, :id => nil})
      author2.save()
      expect(Patron.find(author1.id())).to(eq(author1))
    end
  end

  describe('#update') do
    it('lets you update authors in the database') do
      author = Patron.new({:name => "Craig", :books_checkedout => 1, :id => nil})
      author.save()
      author.update({:name => "Craig", :books_checkedout => 1})
      expect(author.name()).to(eq('Craig'))
      expect(author.books_checkedout()).to(eq(1))
    end
  end

  describe('#delete') do
    it('lets you delete a author from the database') do
      author = Patron.new({:name => "Craig", :books_checkedout => 1, :id => nil})
      author.save()
      author.delete()
      expect(Patron.all()).to(eq([]))
    end
  end
end
