# 题目：输入n个数字，输出它们的平方
n = gets.to_i
nums = gets.split.map(&:to_i)

# 方法一，每行输出一个平方
nums.each do |num|
  puts num * num
end

# 方法二，一行输出所有平方，空格分隔
squares = nums.map{|num| num * num}
puts squares.join(" ")