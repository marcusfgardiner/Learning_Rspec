array1 = %w(uno dos tres)
array2 = %w(one two three)

# array1.inject({}) do |accumulator, iteration|
#   # Injecting array1, therefore array1 is default value of accumulator each time
#   puts accumulator[iteration]
# end

hash = array1.inject({}) do |memo, numero|
  #This is how you set a hash value. hashname[key] = value
  memo[numero] = array2[array1.index(numero)]
  #  # print memo below to  see how the accumulator is growing
   #Return value of each iteration is what is ultimately what is retained in 'memo'
  memo
end

puts 'final hash'
puts hash

# ------------------------------------------------------------------

array1 = %w(uno dos tres)
array2 = %w(one two three)

hash = array1.inject({}) do |memo, numero|
  memo[numero] = array2[array1.index(numero)]
   puts 'First param: Accumulator:'
   puts memo
   puts ""
   puts 'Second param: Iterating value'
   puts numero
   puts ""
   puts ""
  memo
end

puts 'final hash'
puts hash
