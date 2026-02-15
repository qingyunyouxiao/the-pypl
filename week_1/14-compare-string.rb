=begin
算法题练习 比较字符串
给定两个 1~9 的正整数 a 和 b，你需要生成两个字符串：
比较两个字符串的字典序，输出字典序更小的那个。如果两个字符串相等，输出任意一个即可。
字典序比较就像查字典时的顺序，是从左到右逐个字符比较：
第一个字符小的字符串，整体就更小。
如果第一个字符相同，就继续比较下一个，直到出现不同的字符。
=end

input = gets.chomp
a, b = input.split.map(&:to_i)
puts "获取到的 a= #{a}, b= #{b}"

str_a = a.to_s * b
str_b = b.to_s * a

puts "生成的字符串 A：#{str_a}"
puts "生成的字符串 B：#{str_b}"

if str_a < str_b
  puts "#{str_a}"
else
  puts "#{str_b}"
end