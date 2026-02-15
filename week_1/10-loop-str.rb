# 基础示例：打印 1-5
i = 1
while i <= 5
  puts i
  i += 1  # 必须更新计数器，否则会无限循环
end

# until 循环（条件为假时执行，等价于 while not）
j = 1
until j > 5
  puts j
  j += 1
end

# 遍历范围
for num in 1..5
  puts num
end

# 遍历数组
fruits = ["apple", "banana", "orange"]
for fruit in fruits
  puts "我喜欢吃 #{fruit}"
end