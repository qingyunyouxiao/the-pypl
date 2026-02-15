# 简写写法（等价于上面的 hash1）
hash2 = {a: "city_name", b: "age", c: 18}
puts hash2[:b]  # 输出：age

# 你的写法 [a: "city_name"] 实际是包含哈希的数组
arr = [a: "city_name"]  # 等价于 [{:a=>"city_name"}]
puts arr[0][:a]  # 输出：city_name