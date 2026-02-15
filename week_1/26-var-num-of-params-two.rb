def print_user_info(name, **details)
  puts "姓名: #{name}"
  # details 是一个哈希，包含所有传入的关键字参数
  details.each do |key, value|
    puts "#{key.capitalize}: #{value}"
  end
end

# 测试调用
print_user_info("张三", age: 25, city: "北京", job: "程序员")
# 输出：
# 姓名: 张三
# Age: 25
# City: 北京
# Job: 程序员