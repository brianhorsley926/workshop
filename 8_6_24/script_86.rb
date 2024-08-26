require "pry"
# Primarily geared to OOP
puts "Hello, World!" # puts is a method, will return nil every time

var1 = "Hellow, World!"

var2 = 123

var3 = ["a",2,"happy"]

var4 = {color: "blue"} #modern notation (4,5,7 are same thing)

var5 = {"color": "blue"}

var6 = {"color" => "blue"}

var7 = {:color => "blue"}

binding.pry

puts var1, var2, var3, var4, var5, var6, var7

# binding.pry # best friend in web-dev
puts "Goodbye cruel world"

my_fav_color = "blue"

puts "My favorite color is #{my_fav_color}"

puts "\n================== End of File ====================\n"