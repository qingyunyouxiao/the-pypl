class Student
  # 1. 类变量（所有实例共享）- 记录创建的学生总数
  @@student_count = 0
  
  # 2. 常量
  VERSION = "1.0.0"
  MAX_GRADE = 100
  MIN_GRADE = 0
  
  # 3. 构造方法
  def initialize(name, grade)
    @name = name
    @grade = grade
    @@student_count += 1  # 每次创建实例时增加计数
    @id = @@student_count # 给每个学生分配唯一ID
  end
  
  # 4. 实例方法
  # 学习方法
  def study(hours)
    if hours > 0
      puts "#{@name} 学习了 #{hours} 小时"
      # 每学习1小时增加0.2分，但不超过最大值
      improvement = hours * 0.2
      @grade += improvement
      @grade = MAX_GRADE if @grade > MAX_GRADE
      puts "  成绩提升了 #{improvement.round(1)} 分"
    else
      puts "#{@name} 没有学习"
    end
    self  # 返回实例本身，支持链式调用
  end
  
  # 休息方法
  def relax(hours)
    puts "#{@name} 休息了 #{hours} 小时"
    self
  end
  
  # 考试方法
  def take_exam
    puts "#{@name} 参加考试"
    # 模拟考试成绩波动
    exam_score = @grade + rand(-5..5)
    exam_score = MAX_GRADE if exam_score > MAX_GRADE
    exam_score = MIN_GRADE if exam_score < MIN_GRADE
    @grade = exam_score
    puts "  考试成绩: #{exam_score.round(1)}"
    self
  end
  
  # 5. 类方法
  # 获取学生总数
  def self.total_students
    puts "学生总数: #{@@student_count}"
    @@student_count
  end
  
  # 获取系统版本
  def self.version_info
    puts "学生管理系统版本: #{VERSION}"
    VERSION
  end
  
  # 创建优秀学生
  def self.create_excellent_student(name)
    new(name, 95)  # 新学生的初始成绩为95
  end
  
  # 6. 访问器方法
  attr_accessor :name     # 可读可写
  attr_reader :id, :grade # 只读（grade通过方法修改）
  # attr_writer :grade     # 我们不提供直接修改grade的方法，必须通过study等方法
  
  # 自定义的grade设置器（有验证）
  def grade=(new_grade)
    if new_grade >= MIN_GRADE && new_grade <= MAX_GRADE
      @grade = new_grade
    else
      puts "警告: 成绩必须在 #{MIN_GRADE} 到 #{MAX_GRADE} 之间"
    end
  end
  
  # 显示学生信息
  def display_info
    puts "=" * 40
    puts "学生信息:"
    puts "  ID: #{@id}"
    puts "  姓名: #{@name}"
    puts "  成绩: #{@grade.round(1)}"
    puts "=" * 40
  end
  
  # 获取成绩等级
  def grade_level
    case @grade
    when 90..MAX_GRADE
      "优秀"
    when 80...90
      "良好"
    when 70...80
      "中等"
    when 60...70
      "及格"
    else
      "不及格"
    end
  end
  
  # 显示详细报告
  def detailed_report
    display_info
    puts "  成绩等级: #{grade_level}"
    puts "  系统版本: #{VERSION}"
  end
end

# 使用示例
puts "=== 学生管理系统演示 ==="
puts "系统版本: #{Student::VERSION}"
puts

# 1. 创建学生实例
puts "1. 创建学生:"
student1 = Student.new("张三", 75)
student2 = Student.new("李四", 85)

student1.display_info
student2.display_info

puts "\n2. 类方法调用:"
Student.total_students
Student.version_info

puts "\n3. 学生学习过程:"
student1.study(4).relax(1).take_exam
student1.detailed_report

puts "\n4. 创建优秀学生:"
excellent_student = Student.create_excellent_student("王五")
excellent_student.display_info
excellent_student.study(2).take_exam
excellent_student.detailed_report

puts "\n5. 访问器方法测试:"
puts "修改 #{student2.name} 的姓名:"
student2.name = "李小明"
puts "新姓名: #{student2.name}"

puts "\n尝试设置无效成绩:"
student2.grade = 150  # 会触发警告

puts "\n获取只读属性:"
puts "学生ID: #{student2.id}"
puts "当前成绩: #{student2.grade}"

puts "\n6. 最终统计:"
Student.total_students