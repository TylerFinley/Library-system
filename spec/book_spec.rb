require("spec_helper")

describe(Book) do
  describe(".all") do
    it('return all information from database') do
      expect(Book.all).to(eq([]))
    end
  end

  describe('#==') do
    it('is the same title if it has the same title') do
      book1 = Book.new({:title => "Harry Potter", :author => "JK Rowling", :genre => "fantasy", :id => nil })
      book2 = Book.new({:title => "Harry Potter", :author => "JK Rowling", :genre => "fantasy", :id => nil })
      expect(book1).to(eq(book2))
    end
  end

  describe('#save') do
    it('lets you save the book to database') do
      book1 = Book.new({:title => "Harry Potter", :author => "JK Rowling", :genre => "fantasy", :id => nil })
      book1.save()
      expect(Book.all()).to(eq([book1]))
    end
  end

  describe('.find') do
    it('lets you find a book by its ID') do
      book1 = Book.new({:title => "Harry Potter", :author => "JK Rowling", :genre => "fantasy", :id => nil })
      book1.save()
      book2 = Book.new({:title => "Harry Potter", :author => "JK Rowling", :genre => "fantasy", :id => nil })
      book2.save()
      expect(Book.find(book1.id())).to(eq(book1))
    end
  end

  describe('.delete') do
    it('lets you delete a book') do
      book1 = Book.new({:title => "Harry Potter", :author => "JK Rowling", :genre => "fantasy", :id => nil })
      book1.save()
      book1.delete()
      expect(Book.all()).to(eq([]))
    end
  end

  describe("#update") do
    it("lets you update books in the database") do
      book1 = Book.new({:title => "Harry Potter", :author => "JK Rowling", :genre => "fantasy", :id => nil})
      book1.save()
      book1.update({:title => "50 Shades of Grey", :author => "JK Rowling", :genre => "fantasy", :id => nil})
      expect(book1.title()).to(eq("50 Shades of Grey"))
    end
  end
end
