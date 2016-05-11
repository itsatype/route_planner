def permutation(string)
  return [string] if string.size < 2
  ch = string[0]
  permutation(string[1..-1]).each_with_object([]) do |perm, result|
    (0..perm.size).each { |i| result << perm.dup.insert(i,ch) }
  end
end

x = permutation("Leah")
puts x