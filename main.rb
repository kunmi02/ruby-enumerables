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

  def my_none
    i = 0
    while i < length
      return false if yield(self[i])

      i += 1
    end
    true
  end

  def my_count
    if block_given?
      i = 0
      count = 0
      while i < length
        count += 1 if yield(self[i])

        i += 1
      end
      count
    else
      length
    end
  end

  def my_map(proc1 = nil)
    i = 0
    new_array = []
    if !proc1.nil? && proc1.respond_to?(:call)
      puts('It is Proc')
      while i < length
        new_array.push(proc1.call(self[i]))
        i += 1
      end
    elsif block_given?
      puts('It is Block')
      while i < length
        new_array.push(yield(self[i]))
        i += 1
      end
    else
      puts('It is none')
      new_array = self
    end
    new_array
  end

  def my_inject
    i = 1
    net = self[0]
    while i < length
      net = yield(net, self[i])
      i += 1
    end
    net
  end
end

def multiply_els(array)
  array.my_inject { |sum, item| sum * item }
end

arr = [1, 2, 3, 4]

puts('# my_each test')
puts(arr.my_each { |elements| puts elements })

puts('# my_each_with_index test')
puts(arr.my_each_with_index { |e, i| p "#{e}, #{i}" })

puts('# my_select test')
puts(arr.my_select { |e| e.is_a? String })

puts('# my_all test')
puts(arr.my_select { |e| e >= 1 })

puts('# my_none test')

puts('## True')
puts([1, 2, 3, 4].my_none { |item| item == 5 })

puts('## False')
puts([1, 2, 3, 4].my_none { |item| item == 4 })

puts('# my_count test')

puts('## With Condition')
puts([1, 4, 3, 4].my_count { |item| item == 4 })

puts('## Without Condition')
puts([1, 4, 3, 4].my_count)

puts('# my_inject test')
puts([1, 4, 3, 4].my_inject { |sum, item| sum + item })

puts('# multiply_els test')

puts('# my_map test')
proc1 = proc do |item|
  item + 1
end

puts('## No Argument')
puts([1, 2, 3].my_map)

puts('## Non-Proc Argument')
puts([1, 2, 3].my_map('Hello'))

puts('## Proc Argument')
puts([1, 2, 3].my_map(proc1))

puts('## Both Proc and Block')
puts([1, 2, 3].my_map(proc1) { |item| item + 1 })

puts('## Non Proc and Block')
puts([1, 2, 3].my_map('Hello') { |item| item + 1 })

puts('## Only Block')
puts([1, 2, 3].my_map { |item| item + 1 })
