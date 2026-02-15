class Student
  attr_accessor :name, :grade

  def initialize(name, grade)
  @name = name
  @grade = grade
  end

  def study(hours)
    puts "#{@name}学习了#{hours}小时"
    @grade += 0.5 if hours > 2
  end
  
  def display_info
    puts "学生：#{@name}，成绩：#{@grade}"
  end
end

# 使用
student = Student.new("王五", 85)
student.display_info  # 输出：学生：王五，成绩：85
student.study(3)      # 输出：王五学习了3小时
student.display_info # 输出：学生：王五，成绩：85.5