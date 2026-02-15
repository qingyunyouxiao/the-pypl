# read-write.rb
require 'tempfile'
require 'fileutils'

class TextEditor
  def initialize(filenames = [])
    @filenames = filenames.empty? ? [] : filenames
    @current_file_index = 0
    @buffer = {}  # 存储每个文件的编辑内容
    @history = {} # 存储每个文件的操作历史
    @original_content = {} # 存储每个文件的原始内容
  end

  def run
    load_files
    
    puts "=== 文本编辑器启动 ==="
    puts "支持的命令:"
    puts "  write <text>    - 在当前文件写入文本"
    puts "  read            - 读取当前文件"
    puts "  save            - 保存当前文件"
    puts "  save_all        - 保存所有文件"
    puts "  undo            - 撤销上一次写入"
    puts "  list            - 显示所有文件列表"
    puts "  switch <n>      - 切换到第n个文件"
    puts "  status          - 显示状态信息"
    puts "  help            - 显示帮助"
    puts "  exit            - 退出程序"
    puts "  show <filename> - 显示指定文件内容"
    puts "  process_all     - 处理所有文件（ARGF模式）"
    puts ""
    
    command_loop
  end

  private

  def load_files
    if @filenames.empty?
      # 如果没有文件名，尝试从ARGF获取
      if ARGV.empty?
        puts "没有指定文件，请创建一个新文件："
        print "文件名: "
        filename = gets.chomp
        @filenames = [filename]
      else
        @filenames = ARGV.dup
      end
    end
    
    @filenames.each do |filename|
      if File.exist?(filename)
        content = File.read(filename)
        @original_content[filename] = content.dup
        @buffer[filename] = content.dup
        @history[filename] = [content.dup]
        puts "已加载文件: #{filename} (#{content.lines.count}行)"
      else
        puts "创建新文件: #{filename}"
        @original_content[filename] = ""
        @buffer[filename] = ""
        @history[filename] = [""]
      end
    end
    
    show_current_file
  end

  def command_loop
    loop do
      print "\n[#{current_filename}]> "
      input = gets&.chomp
      
      case input
      when /^write\s+(.+)/i
        write_text($1)
      when /^read$/i
        read_current_file
      when /^save$/i
        save_current_file
      when /^save_all$/i
        save_all_files
      when /^undo$/i
        undo
      when /^list$/i
        list_files
      when /^switch\s+(\d+)$/i
        switch_file($1.to_i - 1)
      when /^status$/i
        show_status
      when /^help$/i
        show_help
      when /^show\s+(.+)$/i
        show_file_content($1)
      when /^process_all$/i
        process_all_files
      when /^exit$/i, /^quit$/i
        check_unsaved_changes
        puts "再见！"
        break
      when ""
        # 空输入，不做任何事
      else
        puts "未知命令: #{input}"
        puts "输入 'help' 查看可用命令"
      end
    end
  end

  def write_text(text)
    filename = current_filename
    # 保存当前状态到历史
    @history[filename] ||= []
    @history[filename] << @buffer[filename].dup
    
    # 限制历史记录数量
    @history[filename] = @history[filename].last(10)
    
    # 添加文本
    if @buffer[filename].empty?
      @buffer[filename] = text
    else
      @buffer[filename] += "\n" + text
    end
    
    puts "已添加文本到 #{filename}"
    puts "当前内容预览:"
    puts @buffer[filename].lines.last(3).map { |line| "  #{line}" }.join
  end

  def read_current_file
    filename = current_filename
    puts "=== #{filename} 内容 ==="
    if @buffer[filename].empty?
      puts "(空文件)"
    else
      puts @buffer[filename]
      puts "=" * 40
      puts "总行数: #{@buffer[filename].lines.count}"
      puts "总字符数: #{@buffer[filename].size}"
    end
  end

  def save_current_file
    filename = current_filename
    File.write(filename, @buffer[filename])
    @original_content[filename] = @buffer[filename].dup
    puts "已保存 #{filename}"
  end

  def save_all_files
    @filenames.each do |filename|
      if @buffer[filename] != @original_content[filename]
        File.write(filename, @buffer[filename])
        @original_content[filename] = @buffer[filename].dup
        puts "已保存 #{filename}"
      end
    end
    puts "所有文件已保存"
  end

  def undo
    filename = current_filename
    if @history[filename] && @history[filename].size > 1
      @history[filename].pop # 移除当前状态
      @buffer[filename] = @history[filename].last.dup
      puts "已撤销上一次修改"
      puts "当前内容:"
      puts @buffer[filename].lines.last(3).map { |line| "  #{line}" }.join
    else
      puts "无法撤销 - 没有历史记录"
    end
  end

  def list_files
    puts "=== 文件列表 ==="
    @filenames.each_with_index do |filename, index|
      status = if @buffer[filename] == @original_content[filename]
                 "已保存"
               else
                 "未保存*"
               end
      prefix = (index == @current_file_index) ? "> " : "  "
      puts "#{prefix}#{index + 1}. #{filename} (#{status})"
      puts "    行数: #{@buffer[filename].lines.count}, 大小: #{@buffer[filename].size} 字节"
    end
  end

  def switch_file(index)
    if index >= 0 && index < @filenames.length
      @current_file_index = index
      show_current_file
    else
      puts "无效的文件编号: #{index + 1}"
    end
  end

  def show_status
    filename = current_filename
    puts "=== 状态信息 ==="
    puts "当前文件: #{filename} (#{@current_file_index + 1}/#{@filenames.length})"
    puts "是否已保存: #{@buffer[filename] == @original_content[filename] ? '是' : '否'}"
    puts "历史记录数: #{@history[filename].size}"
    puts "内容统计:"
    puts "  行数: #{@buffer[filename].lines.count}"
    puts "  字符数: #{@buffer[filename].size}"
    puts "  单词数: #{@buffer[filename].split(/\s+/).count}"
    
    # 显示其他文件状态
    unsaved_files = @filenames.select do |f|
      @buffer[f] != @original_content[f]
    end
    unless unsaved_files.empty?
      puts "\n未保存的文件:"
      unsaved_files.each do |f|
        puts "  #{f}"
      end
    end
  end

  def show_current_file
    filename = current_filename
    puts "当前文件: #{filename} (#{@current_file_index + 1}/#{@filenames.length})"
    if @buffer[filename] != @original_content[filename]
      puts "提示: 此文件有未保存的修改"
    end
  end

  def show_file_content(filename)
    if @filenames.include?(filename)
      puts "=== #{filename} 内容 ==="
      puts @buffer[filename]
    else
      puts "文件未加载: #{filename}"
    end
  end

  def process_all_files
    puts "=== 使用 ARGF 处理所有文件 ==="
    
    # 首先保存所有修改
    save_all_files
    
    # 使用 ARGF 读取所有文件
    puts "处理结果:"
    ARGF.each_line do |line|
      filename = ARGF.filename
      line_number = ARGF.lineno
      
      # 这里可以添加各种处理逻辑
      # 例如：显示带行号的内容
      puts "#{filename}:#{line_number}: #{line.chomp}"
      
      # 或者统计信息
      # 或者搜索特定内容等
    end
    
    # 显示总结
    puts "\n处理完成！"
    puts "共处理文件: #{ARGV.size}"
  end

  def check_unsaved_changes
    unsaved_files = @filenames.select do |filename|
      @buffer[filename] != @original_content[filename]
    end
    
    unless unsaved_files.empty?
      puts "\n警告: 以下文件有未保存的修改:"
      unsaved_files.each { |f| puts "  #{f}" }
      print "是否保存？(y/n): "
      if gets.chomp.downcase == 'y'
        save_all_files
      end
    end
  end

  def show_help
    puts <<~HELP
    文本编辑器 - 帮助文档
    ===================
    
    基本操作:
      write <text>     - 在当前文件末尾添加文本
      read             - 显示当前文件的完整内容
      save             - 保存当前文件的修改
      save_all         - 保存所有文件的修改
      undo             - 撤销上一次写入操作
      list             - 显示所有加载的文件列表
      switch <n>       - 切换到列表中的第n个文件
      status           - 显示当前状态和统计信息
      show <filename>  - 显示指定文件的内容
    
    高级功能:
      process_all      - 使用ARGF一次性处理所有文件
                         (会先保存所有修改，然后批量处理) 
    
    文件管理:
      exit/quit        - 退出程序（会提示保存未保存的修改）
      help             - 显示此帮助信息
    
    ARGF 模式说明:
      当使用 process_all 命令时，程序会：
      1. 保存所有修改
      2. 一次性读取所有文件内容
      3. 逐行处理并显示文件名和行号
      4. 适合批量处理、搜索、统计等操作
    
    示例:
      ruby read-write.rb file1.txt file2.txt
      > write Hello World
      > save
      > process_all
    HELP
  end

  def current_filename
    @filenames[@current_file_index]
  end
end

# 主程序
if __FILE__ == $0
  editor = TextEditor.new(ARGV)
  editor.run
end