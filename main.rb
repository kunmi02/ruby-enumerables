module Enumerable
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
