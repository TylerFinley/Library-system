require("spec_helper")

describe(Book)  do
  describe(".all") do
    it('return all information from database')
    expect(Book.all).to(eq([]))
  end
end
