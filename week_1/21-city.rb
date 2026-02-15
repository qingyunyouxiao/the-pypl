# city2.rb - 清晰版本
puts "=" * 40
puts "City Input Reader"
puts "=" * 40

# 方法1：检查是否来自管道/重定向
if ARGF.argv.empty? && $stdin.tty?
  # 完全交互式模式
  print "Please enter a city name: "
  city = gets.chomp
  puts "You entered: #{city}"
  
  print "\nDo you want to enter more cities? (y/n): "
  if gets.chomp.downcase == 'y'
    puts "Enter multiple cities, one per line. Press Ctrl+D when done:"
    more_cities = $stdin.readlines.map(&:chomp)
    puts "\nAll cities entered:"
    more_cities.each_with_index { |c, i| puts "#{i+1}. #{c}" }
  end
else
  # 管道/重定向模式
  puts "Reading from standard input..."
  
  # 读取所有输入
  all_input = $stdin.read
  lines = all_input.lines.map(&:chomp)
  
  puts "First city: #{lines.first}" unless lines.empty?
  puts "Total cities received: #{lines.size}"
  
  if lines.size > 1
    puts "\nAll cities:"
    lines.each_with_index { |city, i| puts "#{i+1}. #{city}" }
  end
end
puts "=" * 40