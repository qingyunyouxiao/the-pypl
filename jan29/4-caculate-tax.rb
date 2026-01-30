=begin
计算税率
=end

taxrate = 0.175
print('enter price ')
string = gets()
float = string.to_f
tax = float * taxrate
print("the float is #{float}, the tax is #{tax}")

taxrate = 0.175
print "Enter price (ex tax): "
s = gets
subtotal = s.to_f
if (subtotal < 0.0) then
subtotal = 0.0
end
tax = subtotal * taxrate
puts "Tax on $#{subtotal} is $#{tax}, so grand total is $#{subtotal+tax}"