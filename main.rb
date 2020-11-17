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
      i = 0, count = 0
      while i < length
        count += 1 if yield(i)

        i += 1
      end
      count
    else
      length
    end
  end

  def my_map
    i = 0, new_array = []
    while i < length
      new_array.push(yield(i))
      i += 1
    end
    new_array
  end

  def my_inject
    i = 1, net = self[0]
    while i < length
      net = yield(net, self[i])
      i += 1
    end
    net
  end
end
