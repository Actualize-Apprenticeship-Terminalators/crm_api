method: accept string as param. 
return: same string in reverse.

alphabet = "abcde"

split_array = alphabet.split("")  #['a', 'b', 'c', 'd', 'e']
reversed_array = []
index = split_array.length - 1

split_array.length.times do
  reversed_array << split_array[index]
  index = index - 1
  
  return reversed_array
end


