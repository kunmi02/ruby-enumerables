# rubocop:disable Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity, Metrics/ModuleLength
module Enumerable
  def my_each
    return to_enum(:my_each) unless block_given?

    i = 0
    while i < to_a.length
      yield(to_a[i])
      i += 1
    end
  end

  def my_each_with_index
    return to_enum(:my_each_with_index) unless block_given?

    i = 0
    my_each do |item|
      yield(item, i)
      i += 1
    end
    self
  end

  def my_select
    return to_enum(:my_select) unless block_given?

    result = []
    each do |e|
      result << e if yield(e)
    end
    result
  end

  def my_all?(data = nil)
    if block_given?
      my_each { |item| return false if yield(item) == false }
      return true
    elsif data.nil?
      my_each { |n| return false if n.nil? || n == false }
    elsif !data.nil? && (data.is_a? Class)
      my_each { |n| return false if n.class != data }
    elsif !data.nil? && (data.is_a? Regexp)
      my_each { |n| return false unless data.match(n) }
    else
      my_each { |n| return false if n != data }
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
      my_each { |item| return false unless yield(item) == false }
      return true
    elsif data.nil?
      my_each { |n| return false unless n.nil? || n == false }
    elsif !data.nil? && (data.is_a? Class)
      my_each { |n| return false unless n.class != data }
    elsif !data.nil? && (data.is_a? Regexp)
      my_each { |n| return false if data.match(n) }
    else
      my_each { |n| return false unless n != data }
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

# rubocop:enable Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity, Metrics/ModuleLength

def multiply_els(array)
  array.my_inject { |sum, item| sum * item }
end
