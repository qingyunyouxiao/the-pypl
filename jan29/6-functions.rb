=begin
在循环中发出单个查询（N+1）
=end

def import project
  @csv.each do |row|
    company = ClientCompany.find_by(code: row[:delivery_code])
    next if company&.deleted? 
  end 
end

