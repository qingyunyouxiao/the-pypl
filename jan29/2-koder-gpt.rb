# 字符串输入
s = gets.chomp

# 数值输入
n = gets.to_i

# 多个数值输入（一行，空格分隔）
a, b = gets.split.map(&:to_i)

# 数值列表输入
m = gets.split.map(&:to_i)

# 一次性读取多行数据
lines = readlines.map(&:chomp) 
