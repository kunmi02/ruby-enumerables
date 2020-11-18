module Enumerable
  def my_each
    for i in self
      yield(i)
    end
  end

  def my_each_with_index
    i = 0
		self.my_each do |item|
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
      false
    elsif data.nil?
      my_each { |n| return true if !n.nil?}
    elsif !data.nil? && (data.is_a? Class)
      my_each { |n| return true if n.class == data }
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
      net = data[0] ? yield(self.first, data[0]) : self.first
      my_each_with_index { |item, index| net = yield(net, item) if index != 0 }
    elsif data[0] && data[1]
      net = data[0]
      my_each { |item| net = net.send(data[1], item) }
    elsif data[0]
      net = self.first
      my_each_with_index { |item, index| net = net.send(data[0], item) if index != 0 }
    end
    net
  end
end

def multiply_els(array)
  array.my_inject { |sum, item| sum * item }
end
