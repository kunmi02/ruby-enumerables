module Enumerable
  def my_each
    for i in self
      yield(i)
    end
  end

  def my_each_with_index
    i = 0
    my_each do |item|
      yield(item, i)
      i += 1
    end
    self
  end

  def my_select
    result = []
    each do |e|
      result << e if yield(e)
    end
    result
  end

  def my_all?(data = nil)
    if block_given?
      my_each do |e|
        return false unless yield(e)
      end
    end
    true
  end

  def my_any?(data = nil)
    if block_given?
      my_each { |item| return true if yield(item) }
    elsif data.nil?
      my_each { |n| return true unless n.nil? }
    elsif data.is_a? Class
      my_each { |n| return true if n.instance_of?(data) }
    else
      my_each { |n| return true if n == data }
    end
    false
  end

  def my_none?(data = nil)
    if block_given?
      my_each { |item| return false if yield(item) }
    elsif !data.nil?
      my_each { |item| return false if item == data }
    else
      my_each { |item| return false if !item.nil? || item != false }
    end
    true
  end

  def my_count(data = nil)
    count = 0
    if block_given?
      my_each { |item| count += 1 if yield(item) }
    elsif !data.nil?
      my_each { |item| count += 1 if item == data }
    else
      count = length
    end
    count
  end

  def my_map(proc1 = nil)
    new_array = []
    if !proc1.nil? && proc1.respond_to?(:call)
      my_each { |item| new_array.push(proc1.call(item)) }
    elsif block_given?
      my_each { |item| new_array.push(yield(item)) }
    else
      new_array = self
    end
    new_array
  end

  def my_inject(*data)
    if block_given?
      net = data[0] ? yield(first, data[0]) : first
      drop(1).my_each { |item| net = yield(net, item) }
    elsif data[0]
      if data[1]
        net = data[0]
        my_each { |item| net = net.send(data[1], item) }
      else
        net = first
        drop(1).my_each { |item| net = net.send(data[0], item) }
      end
    end
    net
  end
end

def multiply_els(array)
  array.my_inject { |sum, item| sum * item }
end

# 9. my_inject
puts 'my_inject'
puts '---------'
p [1, 2, 3, 4].my_inject(10) { |accum, elem| accum + elem } # => 20
p [1, 2, 3, 4].my_inject { |accum, elem| accum + elem } # => 10
p [5, 1, 2].my_inject('+') # => 8
p (5..10).my_inject(2, :*) # should return 302400
p (5..10).my_inject(4) { |prod, n| prod * n } # should return 604800
