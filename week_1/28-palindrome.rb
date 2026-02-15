def palin(text)
  if text == text.split("").reverse.join
  puts "true"
  else
  puts "false"
  end
end
palin("madam")
palin("sadness")