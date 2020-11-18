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
      count = 0
      my_each { |item| count += 1 if yield(item) }
      count
    else
      length
    end
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
