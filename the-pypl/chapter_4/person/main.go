package main

// 对应Java中的Person类
// Go中字段名小写表示私有（仅当前包可见），大写表示公有（可被其他包访问）
type Person struct {
	name string
	age  int
}

// Go中没有构造函数，但可以通过工厂函数来创建实例
func NewPerson(name string, age int) *Person {
	// 可以在这里添加参数校验（比如年龄不能为负数），比Java构造方法更灵活
	if age < 0 {
		age = 0
	}
	return &Person{
		name: name,
		age:  age,
	}
}

func main() {
	// 创建Person实例
	person := NewPerson("Alice", 30)
	// 访问Person字段（需要通过方法，因为字段是私有的）
	println("Name:", person.name)
	println("Age:", person.age)
}
