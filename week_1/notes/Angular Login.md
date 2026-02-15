发布日期：2025年8月10日

主题：学习一门新的语言和框架有很多方法，我选择官方文档，让我们看一下Angular[网站首页](https://angular.dev/overview)。

在学习Angular之前，你需要了解什么是TypeScript。TypeScript是基于JavaScript的强类型编程语言，好的。

**构建Angular的基本要素：组件，模板，依赖注入。**

## 组件
组件包括一个带有组件注释的类、一个组件装饰器、一个HTML的模板和样式。

每个 Angular 组件都有一个**模板**，用于定义该组件渲染到页面上的[DOM](https://developer.mozilla.org/en-US/docs/Web/API/Document_Object_Model)。通过使用模板，Angular 能够随着数据的变化自动保持页面更新。

Angular 还支持属性绑定，以帮助您为 HTML 元素的属性和属性设置值，并将值传递给应用程序的表示逻辑。

```html
<p
  [id]="sayHelloId"
  [style.color]="fontColor">
  You can set my color in the component!
</p>

```

声明事件监听器来监听并响应用户操作，例如按键、鼠标移动、点击和触摸。您可以通过在括号中指定事件名称来声明事件监听器：

```html
<button
  type="button"
  [disabled]="!canClick"
  (click)="sayMessage()">
  Trigger alert message
</button>

```

[disabled] 将组件的属性值绑定到HTML元素的属性上，用于数据从组件到视图的单向绑定，(click) 将HTML元素的事件绑定到组件的方法上，用于将用户的交互事件传递给组件。如何没有方括号或括号，它就是HTML属性。

你可以在模板中使用双花括号绑定动态文本，这告诉 Angular 它负责模板内部的表达式并确保其正确更新。

```plain
@Component({
  template: `
    <p>Your color preference is {{ theme }}.</p>

  `,
  ...
})
export class AppComponent {
  theme = 'dark';
}
```

在这个例子中，当代码片段呈现到页面时，Angular 将替换 {{ theme }} 为 dark。关于组件导入的[更多内容。](https://angular.dev/guide/components)

```plain
<!-- Rendered Output -->
<p>Your color preference is dark.</p>

```

## 依赖注入
依赖注入允许您声明 TypeScript 类的依赖项，而无需处理它们的实例化。Angular 会为您处理实例化。这种设计模式让您可以编写更易于测试且更灵活的代码。理解依赖注入对于开始使用 Angular 来说并非至关重要，但强烈建议将其作为最佳实践。Angular 的许多方面都在一定程度上利用了它。

为了说明依赖注入的工作原理，请考虑以下示例。第一个文件 logger.service.ts 定义了一个 Logger 类。该类包含一个 writeCount 将数字记录到控制台的函数。

```typescript
import { Injectable } from '@angular/core';

@Injectable({providedIn: 'root'})
export class Logger {
  writeCount(count: number) {
    console.warn(count);
  }
}
```

接下来，该文件定义了一个 Angular 组件。该组件包含一个使用Logger 类函数的hello-world-di.component.ts 按钮。为了访问该函数，需要通过构造函数将服务注入到类中。

```typescript
import { Component } from '@angular/core';
import { Logger } from '../logger.service';

@Component({
  selector: 'hello-world-di',
  templateUrl: './hello-world-di.component.html'
})
export class HelloWorldDependencyInjectionComponent  {
  count = 0;

  constructor(private logger: Logger) { }

  onLogMe() {
    this.logger.writeCount(this.count);
    this.count++;
  }
}
```

## CLI命令
Angular CLI是一个命令行界面工具，它自动化特定的开发任务，如服务、构建、打包、更新和测试Angular项目。顾名思义，它使用命令行调用ng可执行文件并使用以下语法运行命令：

```plain
ng [command] [options]
```

在这里，[command]是要执行的命令的名称，而[options]表示可以传递给每个命令的附加参数。要查看所有可用的命令，可以运行以下命令：

```plain
ng help
```

创建包含 Angular 应用程序的新文件。

```plain
ng generate compoment your-compoment
```

启动项目。

```plain
ng serve
```

## 组件结构
组件的 TypeScript 类定义在 app.component.ts 文件中：

```typescript
import { Component } from '@angular/core';
import { HeaderComponent } from './header/header.component';
import { ContentComponent } from './content/content.component';

@Component({
  selector: 'app-root',
  imports: [HeaderComponent,ContentComponent],
  templateUrl: './app.component.html',
  styleUrl: './app.component.css'
})
export class AppComponent {
  title = 'angular-app';
}
```

@Component是一个Angular装饰器，用于定义Angular组件的属性。Angular装饰器是一个接受带有元数据对象作为参数的方法。元数据用于使用以下属性将TypeScript类配置为Angular组件：

• selector：一个CSS选择器，指示Angular在HTML模板中找到相应标签的位置加载组件。Angular CLI默认添加app前缀，但您可以在创建Angular项目时使用--prefix选项自定义它。

• imports：定义组件需要加载的Angular文物列表，以便正确加载，例如其他Angular组件。Angular CLI默认在主应用程序组件中添加RouterOutlet。RouterOutlet用于在Angular应用程序中需要路由能力时使用。

• templateUrl：定义包含组件HTML模板的外部HTML文件的路径。或者，您可以使用template属性提供内联模板。

• styleUrl：定义包含组件CSS样式的外部CSS样式表文件的路径。或者，您可以使用styles属性提供内联样式。

## 添加静态文件
在本项目代码中，angular.png图标文件储存在 /src/assets中，需要创建并修改angular.json。

```html
<app-header
[title]="'The Frontend Project'"
[logopath]="'assets/angular.png'"
/>
<app-content/>
```

```json
    "assets": [
        "src/assets",
    ],
    "styles": [
      "src/styles.css",
      "node_modules/bootstrap/dist/css/bootstrap.min.css"
    ],
```

## 内容显示
```typescript
export class ContentComponent {

  componentToShow = "welcome";
    atLogin() {
      this.componentToShow = "login";
    }
    atLogout() {
      this.componentToShow = "welcome";
    }
}

```

```html
<app-buttons (loginClick)="atLogin()" (logoutClick)="atLogout()" />
<app-welcome-content *ngIf="componentToShow == 'welcome'" />
<app-login-form *ngIf="componentToShow == 'login'" />
```

关于ngIf的[用法](https://v16.angular.io/api/common/NgIf#description)，注意大小写。

## 来自组件的父方法
```typescript
import { Component, Output, EventEmitter } from '@angular/core';

@Component({
  selector: 'app-buttons',
  imports: [],
  templateUrl: './buttons.component.html',
  styleUrl: './buttons.component.css'
})
export class ButtonsComponent {

  @Output() loginClick=new EventEmitter();
  @Output() logoutClick=new EventEmitter();
  

}
```

将按钮绑定到事件的方法。

```html
<div class="row">
    <div class="col-md-12 text-center" style="margin-top: 30px;">
        <button class="btn btn-primary" style="margin: 10px;" (click)="loginClick.emit()">Login</button>

        <button class="btn btn-dark" style="margin: 10px;" (click)="logoutClick.emit()">Logout</button>

    </div>

</div>

```

## 创建后端
<!-- 这是一张图片，ocr 内容为： -->
![](C:\Users\PC\Pictures\Screenshots\image-20250810101908578.png)

这是我的后端项目结构，我创建了后端接口来接受前端 /login 请求。

```java
// LoginController.java

package com.example.demo.controllers;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;
import java.util.HashMap;
import java.util.Map;

@RestController
public class LoginController {

    @PostMapping("/login")
    public Map<String, Object> login(@RequestBody Map<String, String> credentials) {
        String username = credentials.get("username");
        String password = credentials.get("password");

        boolean success = "2293".equals(username) && "2293".equals(password);

        Map<String, Object> response = new HashMap<>();
        response.put("status", success ? "success" : "fail");
        response.put("message", success ? "Login successful" : "Invalid credentials");
        return response;
    }
}

```

```java
// CorsConfig.java

package com.example.demo.config;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.CorsRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@Configuration
public class CorsConfig {

    @Bean
    public WebMvcConfigurer corsConfigurer() {
        return new WebMvcConfigurer() {
            @Override
            public void addCorsMappings(CorsRegistry registry) {
                registry.addMapping("/**")
                        .allowedOrigins("http://localhost:4200")
                        .allowedMethods("GET", "POST", "PUT", "DELETE", "OPTIONS")
                        .allowedHeaders("*");
            }
        };
    }
}

```

启动前后端项目，在前端登录界面输入用户名和密码，返回 Login sucessful。

### <font style="color:rgb(31, 35, 41);">1. 安装 axios（含类型声明）</font>
<font style="color:rgb(31, 35, 41);">在终端的</font>`<font style="color:rgb(31, 35, 41);background-color:rgba(0, 0, 0, 0);">frontend-demo</font>`<font style="color:rgb(31, 35, 41);">目录下执行：</font>

```plain
npm install axios
npm install @types/axios --save-dev
```

### <font style="color:rgb(31, 35, 41);">2. 安装 bootstrap</font>
<font style="color:rgb(31, 35, 41);">同样在</font>`<font style="color:rgb(31, 35, 41);background-color:rgba(0, 0, 0, 0);">frontend-demo</font>`<font style="color:rgb(31, 35, 41);">目录下执行：</font>

```plain
npm install bootstrap
```

<font style="color:rgb(31, 35, 41);">安装完成后，重新运行</font>`<font style="color:rgb(31, 35, 41);background-color:rgba(0, 0, 0, 0);">ng serve</font>`<font style="color:rgb(31, 35, 41);">即可解决这两个依赖缺失的错误。</font>

### <font style="color:rgb(31, 35, 41);">3.验证依赖是否添加</font>
 查看项目根目录的 `<font style="color:rgb(31, 35, 41);background-color:rgba(0, 0, 0, 0);">package.json</font>` 文件，检查 `<font style="color:rgb(31, 35, 41);background-color:rgba(0, 0, 0, 0);">dependencies</font>` 节点下是否有：  

```json
"dependencies": {
  "axios": "^x.x.x", // 具体版本号
  "bootstrap": "^x.x.x" // 具体版本号
},
"devDependencies": {
  "@types/axios": "^x.x.x" // TS 项目会有这行
}
```

