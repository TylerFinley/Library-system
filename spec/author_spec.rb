require('spec_helper')

describe(Author) do
  describe('.all') do
    it('return an empty array at first') do
      expect(Author.all()).to(eq([]))
    end
  end

  describe(".==") do
    it('is the same first name if it has the same first name') do
      author1 = Author.new({:first_name => "JK", :last_name => "Rowling"})
      author2 = Author.new({:first_name => "JK", :last_name => "Rowling"})
      expect(author1).to(eq(author2))
    end
  end


  describe('#save') do
    it('lets you save the author to a book') do
      author1 = Author.new({:first_name => "JK", :last_name => "Rowling"})
      author1.save
      expect(Author.all()).to(eq([author1]))
    end
  end

end
