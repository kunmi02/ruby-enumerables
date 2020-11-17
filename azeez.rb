module Enumerable
def my_each
    i = 0
    while self[i]
      yield(self[i])
      i += 1
    end
  end

  def my_each_with_index
    my_each { |e| yield(e, index(e)) }
  end

  def my_select
    result = []
    each do |e|
      result << e if yield(e)
    end
    result
  end

  def my_all?
    my_each do |e|
      return false unless yield(e)
    end
    true
  end
end

  arr = [1, 2, 3, 4]

p arr.my_each {|elements| puts elements}

print 'My each with Index below'
arr.my_each_with_index { |e, i| p "#{e}, #{i}" }

p arr.my_select { |e| e.is_a? String }