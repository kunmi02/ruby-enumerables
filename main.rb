module Enumerable
  def my_none
    i = 0
    while i < length
      return false if yield(self[i])

      i += 1
    end
    true
  end
end
