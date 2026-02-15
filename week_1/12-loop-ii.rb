# 遍历范围
(1..5).each do |num|
  puts num
end

# 遍历数组
fruits = ["apple", "banana", "orange"]
fruits.each do |fruit|
  puts "水果：#{fruit}"
end

# 单行简写（大括号替代 do...end）
(1..3).each { |num| puts "数字：#{num}" }

# each_with_index：带索引的遍历
fruits.each_with_index do |fruit, index|
  puts "#{index + 1}. #{fruit}"
end

# 示例：遍历 1-3，遇到偶数时重试当前迭代（会无限循环，需手动控制）
nums = [1, 2, 3]
nums.each do |num|
  puts "当前数字：#{num}"
  
  if num == 2
    puts "发现偶数，重试当前迭代！"
    redo  # 重新执行当前迭代（num 仍然是 2，不会变成 3）
  end
end

# 输出结果（无限循环）：
# 当前数字：1
# 当前数字：2
# 发现偶数，重试当前迭代！
# 当前数字：2
# 发现偶数，重试当前迭代！
# ... 无限重复

# 模拟网络请求，随机失败，失败后重试（最多 3 次）
def fetch_data
  # 模拟 50% 概率失败
  if rand(2) == 0
    raise "网络请求失败"
  else
    return "请求成功，数据：{city: '北京'}"
  end
end

attempts = 0
max_attempts = 3

begin
  attempts += 1
  puts "第 #{attempts} 次请求..."
  result = fetch_data
  puts result
rescue => e
  puts "错误：#{e.message}"
  if attempts < max_attempts
    retry  # 重新执行 begin 块（整个请求逻辑从头来）
  else
    puts "已重试 #{max_attempts} 次，请求最终失败"
  end
end

# 可能的输出：
# 第 1 次请求...
# 错误：网络请求失败
# 第 2 次请求...
# 错误：网络请求失败
# 第 3 次请求...
# 请求成功，数据：{city: '北京'}