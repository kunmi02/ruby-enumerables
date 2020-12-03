require './main'

describe Enumerable do
  describe '#each' do
    it 'Add 1 to each item' do
      array = []
      [1, 2, 3, 4].my_each { |item| array.push(item + 1) }
      expect(array).to eql([2, 3, 4, 5])
    end
  end
  describe '#each_with_index' do
    it 'Add to each item, their index' do
      array = []
      [1, 2, 3, 4].my_each_with_index { |item, i| array.push(item + i) }
      expect(array).to eql([1, 3, 5, 7])
    end
  end
  describe '#select' do
    it 'Fetch even numbers' do
      expect([1, 2, 3, 4].my_select(&:even?)).to eql([2, 4])
    end
    it 'Fetch those greater than 2' do
      expect([1, 2, 3, 4].my_select { |item| item > 2 }).to eql([3, 4])
    end
  end
  describe '#all' do
    it 'Check if all items are even' do
      expect([1, 2, 3, 4].my_all?(&:even?)).to eql(false)
    end
    it 'Check if all items are even' do
      expect([2, 4, 6].my_all?(&:even?)).to eql(true)
    end
    it 'Check if all items are Integers' do
      expect([1, 2, 3, 4].my_all?(Integer)).to eql(true)
    end
  end
  describe '#none' do
    it 'Check if none of the items are even' do
      expect([1, 2, 3, 4].my_none?(&:even?)).to eql(false)
    end
    it 'Check if none of the items are even' do
      expect([1, 3, 5].my_none?(&:even?)).to eql(true)
    end
    it 'Check if none of the items are Integers' do
      expect([1, 2, 3, 4].my_none?(Integer)).to eql(false)
    end
    it 'Check if none of the items are Strings' do
      expect([1, 2, 3, 4].my_none?(String)).to eql(true)
    end
  end
  describe '#any' do
    it 'Check if any of the items is even' do
      expect([1, 2, 3, 4].my_any?(&:even?)).to eql(true)
    end
    it 'Check if any of the items is even' do
      expect([1, 3, 5].my_any?(&:even?)).to eql(false)
    end
    it 'Check if any of the items is Integer' do
      expect([1, 2, 3, 4].my_any?(Integer)).to eql(true)
    end
    it 'Check if any of the items is String' do
      expect([1, 2, 3, 4].my_any?(String)).to eql(false)
    end
  end
  describe '#count' do
    it 'Counts all even items' do
      expect([1, 2, 3, 4].my_count(&:even?)).to eql(2)
    end
    it 'Counts all items equal to 2' do
      expect([1, 2, 3, 4].my_count { |item| item == 2 }).to eql(1)
    end
    it 'Counts all items that are Integers' do
      expect([1, 2, 3, 4].my_count(Integer)).to eql(4)
    end
    it 'Counts all items that are String' do
      expect([1, 2, 3, 4].my_count(String)).to eql(0)
    end
  end
  describe '#map' do
    it 'Add 1 to all items' do
      expect([1, 2, 3, 4].my_map { |item| item + 1 }).to eql([2, 3, 4, 5])
    end
    it 'Add ? to all items' do
      expect(%w[Hey Jude].my_map { |word| word << '?' }).to eql(['Hey?', 'Jude?'])
    end
  end
  describe '#inject' do
    it 'Returns sum of items' do
      expect([1, 2, 3, 4].my_inject { |sum, item| sum + item }).to eql(10)
    end
    it 'Returns product of items' do
      expect([1, 2, 3, 4].my_inject(:*)).to eql(24)
    end
    it 'Returns product of items times 2' do
      expect([1, 2, 3, 4].my_inject(2, :*)).to eql(48)
    end
  end
end
