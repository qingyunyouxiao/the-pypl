ARGF.each_line do |line|
  puts "#{ARGF.filename}: #{line}"
end
