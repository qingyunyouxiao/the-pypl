let Age = 29;
const sayAge = () => alert(this.Age);
alert(window.Age);
sayAge();
window.sayAge();
