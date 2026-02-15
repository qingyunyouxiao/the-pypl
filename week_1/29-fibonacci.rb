def fib(count)
  a = 0
  b = 1
  puts a
  puts b
  current = 0
  while current < count - 2
    puts c = a + b
    a = b
    b = c
    current += 1
  end
end
fib(10)