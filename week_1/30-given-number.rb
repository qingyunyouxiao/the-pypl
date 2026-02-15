# 计算x的阶乘
def given(x)
puts 1.upto(x).inject('*')    
end
given(5)
# 从数组中找出二大的数
def secbiggest(arr)
  puts arr.sort[-2]
end
secbiggest([1, 2, 3, 4, 5])