# 基础用法：接收任意数量的参数
def sum(*numbers)
  # numbers 是一个数组，包含所有传入的参数
  total = 0
  numbers.each { |num| total += num }
  total
end

# 测试调用
puts sum(1, 2)          # 输出: 3 (numbers = [1, 2])
puts sum(1, 2, 3, 4)    # 输出: 10 (numbers = [1, 2, 3, 4])
puts sum()              # 输出: 0 (numbers = [])

# 结合固定参数使用
def greet(greeting, *names)
  names.each { |name| puts "#{greeting}, #{name}!" }
end

greet("Hello", "Alice", "Bob", "Charlie")
# 输出：
# Hello, Alice!
# Hello, Bob!
# Hello, Charlie!