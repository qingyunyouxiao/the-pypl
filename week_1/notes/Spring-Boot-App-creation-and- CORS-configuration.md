发布日期：2023年9月25日

主题：这是我将介绍如何创建全栈应用程序的系列文章的第一篇。创建全栈应用程序时，我必须考虑前端应用程序和后端应用程序之间的行为。传输的数据、逻辑的去向、安全性……

在第一篇文章中，我将首先创建 Spring Boot 应用程序并配置 CORS 以便任何前端（Angular 或 React）可以访问。

内容：

+ Spring Boot 应用程序中所需的依赖项
+ 创建我的第一个端点
+ 允许前端通信的 CORS 配置
+ 错误管理的 Aspect 配置

## 创建 Spring Boot 项目
第一步，转到[Spring Initializr](https://start.spring.io/)。

<!-- 这是一张图片，ocr 内容为： -->
![](https://sergiolema.dev/wp-content/uploads/2023/08/spring-intializr.png?w=699)

在这里，我将创建我的 Spring Boot 项目。Spring Initializr 是一个网站，它创建了包含所有初始配置的 Spring Boot 应用程序，可供使用。

我必须设置 Maven Group 和 Artifact。项目名称和描述。

我选择了 Maven 依赖管理、Java 语言、最新稳定的 Spring Boot 版本、最新稳定的 Java 版本和 Jar 打包。

另一方面，我可以选择项目中所需的依赖项。

<!-- 这是一张图片，ocr 内容为： -->
![](https://sergiolema.dev/wp-content/uploads/2023/08/spring-initializr-dependencies-1.png?w=737)

Spring Initializr 依赖项

我将从 Spring Web 依赖项开始，因为我希望我的 Spring Boot 应用程序具有端点并与 Web 请求进行通信。

然后，我添加了[Lombok](https://sergiolema.dev/2021/02/26/project-lombok-and-mapstruct-with-spring-boot/)来生成一些代码。我还添加了 Mapstruct，但 Spring Initializr 中没有这个。我稍后会手动添加。

现在，我准备点击“生成”按钮并下载项目。

一旦我在[IntelliJ](https://www.jetbrains.com/idea/)（或任何其他 IDE）中打开项目，我就会添加 Mapstruct 依赖项。

```java
<dependency>
    <groupId>org.mapstruct</groupId>

    <artifactId>mapstruct</artifactId>

    <version>1.5.3.Final</version>

</dependency>

<dependency>
    <groupId>org.mapstruct</groupId>

    <artifactId>mapstruct-processor</artifactId>

    <version>1.5.3.Final</version>

</dependency>

```

确保将 Mapstruct 依赖项放在 Lombok 依赖项之后。因为 Mapstruct 需要 Lombok 生成的代码。

我的项目已创建。让我们看一下文件结构。

<!-- 这是一张图片，ocr 内容为： -->
![](https://sergiolema.dev/wp-content/uploads/2023/08/project-structure.png?w=734)

Spring Initializr 创建了_src_文件夹，用于存放所有代码。其中，有_main_文件夹和_test_文件夹，用于将生产代码与单元测试分开。然后，还有一个_java_文件夹，用于存放所有 Java 代码；还有一个_resources_文件夹，用于存放所有配置文件和资源文件。

最后，我还有一个_HELP.md_文件，它为我开始开发应用程序提供了一些资源。我可以在开始开发后立即删除它，并创建一个_README.md_文件，其中包含一些有关项目的信息。

由于我选择 Maven 作为依赖管理工具，因此我有一个_pom.xml_文件，其中包含项目的所有依赖项。我还有一个_mvnw_文件（ Windows 用户可以使用_mvnw.cmd_文件），它是 Maven 的包装器。我不需要在我的笔记本电脑上安装 Maven，只需运行这个包装器即可。

因此，构建我的项目的第一个命令是：

```plain
./mvnw clean package
```

并启动项目：

```plain
./mvnw spring-boot:run
```

## 我的第一个端点
让我们首先创建必要的 Java 包。

_在com.sergio.backend_中，我将创建_controllers_包。由于它将包含许多控制器，因此使用复数形式。并在其中创建我的第一个控制器_GreetingsController.java_。控制器、服务、存储库和实体始终使用单数形式。

```java
@RestController
public class GreetingsController {
 
    @GetMapping("/greetings")
    public ResponseEntity<ContentDto> greetings() {
        return ResponseEntity.ok(new ContentDto("Hello from backend!"));
    }
}
```

首先，我使用注解*@RestController*将控制器配置为[REST](https://www.redhat.com/en/topics/api/what-is-a-rest-api)控制器。这样我就可以用 JSON 进行通信，并且可以将对象转换为 JSON 格式，反之亦然。

创建端点时，我可以直接使用注解定义 HTTP 方法。使用*@GetMapping*会将方法映射到 GET 操作。在注解中，我添加了要映射的路由。

让我们看一下该方法的返回类型_ResponseEntity_ 。ContentDto是我稍后会创建的对象。如前所述，REST 控制器允许我将对象转换为 JSON。这意味着它会将_ContentDto_对象转换为 JSON。这是通过 REST 控制器注解和_ResponseEntity_对象实现的。

最后是返回值。我想返回*“Hello from backend!”_，但要返回 JSON 对象。首先，我用想要的值实例化_ContentDto 。然后，我用*_ResponseEntity.ok_包装我的dto。ok表示包含给定内容的 200 HTTP 响应_代码_。

让我们看看从终端调用此端点时的结果。

```plain
backend git:(main) curl localhost:8080/greetings -vvv
*   Trying 127.0.0.1:8080...
* Connected to localhost (127.0.0.1) port 8080 (#0)
> GET /greetings HTTP/1.1
> Host: localhost:8080
> User-Agent: curl/7.88.1
> Accept: */*
> 
< HTTP/1.1 200 
< Vary: Origin
< Vary: Access-Control-Request-Method
< Vary: Access-Control-Request-Headers
< Content-Type: application/json
< Transfer-Encoding: chunked
< Date: Sat, 19 Aug 2023 08:39:25 GMT
< 
* Connection #0 to host localhost left intact
{"content":"Hello from backend!"}% 
```

信息量很大。我们只关注其中几行。

第一行是我用来向后端发送请求的命令。curl是一个发送 HTTP 请求的命令。localhost _:8080是我的 Spring Boot 应用程序*__的_运行地址。greetings是我创建的端点。我添加了__-vvv_来显示有关请求的更多详细信息_。*

*所有以>_开头的行都是发送给应用程序的信息。所有以_<*开头的行都是从应用程序接收的信息。

在第 4 行，我可以看到我向端点_greets_发送了一个 GET 请求。

在第 9 行，我收到来自应用程序的 HTTP 响应代码 200。

最后，最后一行，我得到了应用程序的响应，格式为 JSON。JSON 之所以有这样的结构（_内容字段），是因为**ContentDto_对象内部有字段。

因此，让我们在一个新的包_dtos中创建**ContentDto_对象。

```java
public record ContentDto(String content) {``}
```

## CORS 配置
我已经从终端发送了最后一个请求。但是如果我想从前端请求后端，我必须调整我的后端。

默认情况下，后端仅接受来自同一 URL（_localhost:8080_）的请求。使用 Angular 或 React 等前端时，它们会运行在不同的 URL（_localhost:4200_或_localhost:3000_）上。因此，Spring Boot 会阻止来自前端的请求。如果您想了解更多详细信息，请观看以下[视频](https://youtu.be/uMJnAxapF7E)。

因此，我需要配置后端以接受来自其他 URL 的请求。首先，我将创建一个新的包_config_。接下来，我将创建一个包含 Web 配置的类_WebConfig_。

```java
@Configuration
public class WebConfig {
 
    @Bean
    public WebMvcConfigurer corsConfig() {
        return new WebMvcConfigurer() {
            @Override
            public void addCorsMappings(CorsRegistry registry) {
                registry.addMapping("/**")
                        .allowedOrigins("http://localhost:4200")
                        .allowedMethods(HttpMethod.GET.name(),
                                HttpMethod.POST.name(),
                                HttpMethod.DELETE.name())
                        .allowedHeaders(HttpHeaders.CONTENT_TYPE,
                                HttpHeaders.AUTHORIZATION);
            }
        };
    }
```

第一个注释@Configuration是必需的，以便 Spring 检测并考虑这个配置类。

@Bean注释还告诉 Spring 它必须执行并保存以下方法的结果。

该方法返回一个WebMvcConfigurer实例。这是 Web 应用程序的行为。Spring 已经有一个默认配置（这就是为什么我收到错误）。我想要这个默认配置，但要覆盖 CORS 配置。因此，我只实现了addCorsMappings方法。

我首先使用addMapping(“/**”)添加受影响的路由。“/**”表示我希望将以下配置应用于所有路由。

然后我使用allowedOrigins(“ [http://localhost:4200”](http://localhost:4200&/#8221) ;)指示允许的来源和允许的URL 。如果我需要来自多个前端的多个URL，此方法将接受Spring的列表。

默认情况下，它只接受 GET HTTP 方法。为了接受更多 HTTP 方法，我使用allowedMethods(…)来包含所有我想要的 HTTP 方法。

默认情况下，它不接受任何 HTTP 标头。但我需要后端使用 JSON 内容和一些授权标头。因此，我添加了*allowedHeaders(…) ，*其中包含我需要的所有 HTTP 标头。

## 错误管理的方面配置
当我的应用程序抛出异常时会发生什么？前端会返回什么？

我不知道。如果我不知道，那就不好了。所以，我们来处理一下这种行为吧。

我首先在包_exceptions_中创建自己的异常。

```java
public class AppException extends RuntimeException {
    private final HttpStatus status;
 
    public AppException(String message, HttpStatus status) {
        super(message);
        this.status = status;
    }
 
    public HttpStatus getStatus() {
        return status;
    }
}
```

首先要扩展RuntimeException。这样，我就不需要用 try-catch 来包围异常了。

默认情况下，任何 Java 异常都有一个 message 字段，因此我将只添加一个HttpStatus字段。我将使用此字段来自定义我的应用程序在发生错误时返回的 HTTP 代码。

每当我的应用程序出现不连贯的行为时，我都会使用此异常。例如资源未找到、验证错误等等。

现在让我们在配置包中创建具有错误管理的方面。

```java
@ControllerAdvice
public class RestExceptionHandler {
 
    @ExceptionHandler(value = { AppException.class })
    @ResponseBody
    public ResponseEntity<ErrorDto> handleAppException(AppException ex) {
        return ResponseEntity
                .status(ex.getStatus())
                .body(new ErrorDto(ex.getMessage()));
    }
 
    @ExceptionHandler(value = { Exception.class })
    @ResponseBody
    public ResponseEntity<ErrorDto> handleException(AppException ex) {
        return ResponseEntity
                .internalServerError()
                .body(new ErrorDto("Unknown error"));
    }
}
```

该类必须使用*@ControllerAdvice*注解，以便 Spring 使用它来覆盖所有端点。这样，如果抛出任何异常，所有端点都会调用这些方法。

在第一个方法中，我使用注解@ExceptionHandler()并传入我自己的异常AppException的值，这样就能只捕获我自己的异常。在第二个方法中，我使用泛型Exception来捕获剩余的异常。**我必须小心地遵循方法的顺序，这样它就会先检查我自己的异常，然后再检查泛型异常。**

最后，我返回一个 ResponseEntity，就像在控制器中使用新的 DTO（数据传输对象）一样。我们最后创建一个包含单个字段的 DTO。

```java
public record ErrorDto (String message) { }
```

## 结论
这个简单的应用程序允许通过 CORS 配置与前端进行通信，并处理应用程序中发生的任何异常，正确返回可读消息。

