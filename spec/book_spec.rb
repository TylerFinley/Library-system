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
end
