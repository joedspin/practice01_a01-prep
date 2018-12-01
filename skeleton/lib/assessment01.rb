require 'byebug'
class Array

  # Monkey patch the Array class and add a my_inject method. If my_inject receives
  # no argument, then use the first element of the array as the default accumulator.

  def my_inject(accumulator = nil, &block)
    i = 0
    if accumulator.nil?
      accumulator = self.first
      i = 1
    end
    while i < length
      accumulator = block.call(accumulator, self[i])
      i += 1
    end
    accumulator
  end
end

# primes(num) returns an array of the first "num" primes.
# You may wish to use an is_prime? helper method.

def is_prime?(num)
  (2..num-1).none? { |n| num % n == 0 }
end

def primes(num)
  arr_primes = []
  n = 2
  until arr_primes.length == num
    arr_primes << n if is_prime?(n)
    n += 1
  end
  arr_primes
end

# Write a recursive method that returns the first "num" factorial numbers.
# Note that the 1st factorial number is 0!, which equals 1. The 2nd factorial
# is 1!, the 3rd factorial is 2!, etc.

def factorials_rec(num)
  return [1] if num == 1
  factorials =  factorials_rec(num - 1)
  factorials << factorials.last * (num - 1)
  factorials
end

class Array

  # Write an Array#dups method that will return a hash containing the indices of all
  # duplicate elements. The keys are the duplicate elements; the values are
  # arrays of their indices in ascending order, e.g.
  # [1, 3, 4, 3, 0, 3, 0].dups => { 3 => [1, 3, 5], 0 => [4, 6] }

  def dups
    hsh_dups = Hash.new { |hash, key| hash[key] = []}
    self.each_with_index do |num, index|
      hsh_dups[num] << index
    end
    hsh_dups.reject { |key, arr_indices| arr_indices.length <= 1 }
  end
end

class String

  # Write a String#symmetric_substrings method that returns an array of substrings
  # that are palindromes, e.g. "cool".symmetric_substrings => ["oo"]
  # Only include substrings of length > 1.

  def symmetric_substrings
    arr_sym = []
    (0..self.length-1).each do |i|
      (i+1..self.length).each do |j|
        sub_string = self[i..j]
        if sub_string == sub_string.reverse && arr_sym.none?(sub_string)
          arr_sym << sub_string
        end
      end
    end
    arr_sym.reject { |word| word.length < 2 }
  end
end

class Array

  # Write an Array#merge_sort method; it should not modify the original array.

  def merge_sort(&prc)
    prc ||= Proc.new { |x, y| x <=> y }
    return self if length <= 1
    mid = length / 2
    Array.merge(
      self[0...mid].merge_sort(&prc),
      self[mid..-1].merge_sort(&prc),
      &prc
    )
  end

  private
  def self.merge(left, right, &prc)
    merged = []
    until left.empty? || right.empty?
      case prc.call(left[0], right[0])
      when -1
          merged << left.shift
      when 0
          merged << left.shift
      when 1
          merged << right.shift
      end
    end
    merged.concat(left)
    merged.concat(right)
  end
end
