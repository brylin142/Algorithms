require_relative 'p05_hash_map'

def can_string_be_palindrome?(string) 
  string_array = string.split("")
  # letters = HashMap.new(string.length)
  letters = Hash.new(0)
  string_array.each { |ch| letters[ch] += 1 }

  even = Hash.new(0)
  letters.keys.each { |uniq_ch| even[uniq_ch] += 1 if letters[uniq_ch].even? }
  
  num_uniq = letters.keys.count
  return true if num_uniq - even.keys.count <= 1
  false
end
