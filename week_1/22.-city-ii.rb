puts "test"
print "Enter the city name: "

# 检查标准输入是否是终端（交互式）还是来自管道/文件
if $stdin.tty?
  # 交互式模式：等待用户输入
  city = gets.chomp
  puts "The city you entered is: #{city}"
  puts "\nNow enter more cities (Ctrl+D to end):"
  inputs = $stdin.read
else
  # 管道/重定向模式：先读取第一行作为城市
  city = gets.chomp rescue ""
  puts "The city you entered is: #{city}"
  
  # 然后读取剩余所有内容
  inputs = $stdin.read
end

puts "\n--- All remaining input ---"
puts inputs
puts "--- End of input ---"