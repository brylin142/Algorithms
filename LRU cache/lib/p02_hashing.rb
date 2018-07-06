class Fixnum
  # Fixnum#hash already implemented for you
end

class Array
  def hash
    result = 0
    each_with_index do |el, idx|
      result += el.hash * idx.hash
    end
    result
  end
end

class String
  def hash
    array = split("")
    alphabet = ("a".."z").to_a
    result = 0
    array.each_with_index do |el, idx|
      result += alphabet.index(el).hash * idx.hash
    end
    result
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    array = to_a.sort
    array.hash
  end
end
