=begin
访问关联模型时发生延迟加载
课题：判定所需的是部分信息，但整个模型对象都被加载到内存中（造成内存浪费）
在这里会发生N+1问题，并且ProjectCategory的所有列都会被加载
=end

projects.find_each do |project|
    next unless project.project_category.outsource_type?
    agreement = project.client_company.contract_stats.find_by()
    print(agreement)
end 
