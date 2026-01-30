=begin
# B组题目  宫殿
# 一个国家决定建造宫殿。
# 已知海拔数H米的点的平均温度公式：T−H×0.006，
# T是给定的基准温度（摄氏度）。
# 已有n个拟议的地点。广场海拔为H1...Hn（米）。
# 其中，乔伊西诺公主命令你选择平均气温最接近A摄氏度的地方，并在那里建造宫殿。
# 输入T、A、n和H1...Hn，都是整数，但公式里用浮点数计算。
# 打印宫殿建造地点的下标（从1开始）。
# 可以保证解是唯一的。
=end

# 提示：为了避免浮点数误差，我们可以将温度公式乘以 1000。
# h = gets.split.map(&:to_i) 会读取整行并分割成数组，所以不需要用 n 来限制读取次数。
# 下面是代码：

t, a = gets.split.map(&:to_i) 
h = gets.split.map(&:to_i)

min_diff = Float::INFINITY
ans = 0

h.each_with_index do |height, i|
    temp_scaled = 1000 * t - 6 * height
    diff = (temp_scaled - 1000 * a).abs
    if diff < min_diff
            min_diff = diff
            ans = i + 1
    end
end

puts ans
