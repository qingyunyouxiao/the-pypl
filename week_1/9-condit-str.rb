# 基础用法
fruit = "apple"

case fruit
when "apple"
  puts "苹果，红色的水果"
when "banana"
  puts "香蕉，黄色的水果"
when "orange"
  puts "橙子，橙色的水果"
else
  puts "未知水果"
end

# 高级用法：支持范围匹配、多值匹配
age = 25
case age
when 0..12
  puts "儿童"
when 13..17
  puts "青少年"
when 18..60, 61..100  # 多值匹配
  puts "成年人"
else
  puts "年龄异常"
end