<font style="color:rgb(51, 51, 51);">主题：在 docker 中启动 momgodb, （学习log4j2，将 log4j2 的日志输出到 mongodb）。</font>

<font style="color:rgb(51, 51, 51);">日期：2025年12月18日</font>

<font style="color:rgb(51, 51, 51);">如果您还不熟悉 Docker Hub，这里做一个简单的介绍。Docker Hub 是一个平台，您可以在这里找到并分享公开或私有的 Docker 镜像。它与 GitHub 和 GitLab 非常相似。简而言之，它是一个 Docker 镜像仓库。</font>

<font style="color:rgb(51, 51, 51);">第一步是从 Docker Hub 拉取官方 Docker 镜像。</font>

<!-- 这是一张图片，ocr 内容为： -->
![](https://cdn.nlark.com/yuque/0/2025/png/54784325/1766024059279-02e4fe3f-ae09-48f5-b3fc-a5606b0aa777.png)

_<font style="color:rgb(51, 51, 51);">Docker Hub 中的 MongoDB 镜像</font>_

docker pull mongo:latest

<!-- 这是一张图片，ocr 内容为： -->
![](https://cdn.nlark.com/yuque/0/2025/png/54784325/1766024057529-ceba1c1e-9592-4e3e-ab83-6ae69369637a.png)

_<font style="color:rgb(51, 51, 51);">从 Docker Hub 拉取 MongoDB 镜像的示例输出</font>_

<font style="color:rgb(51, 51, 51);">完成 Mongo 镜像拉取后，打开 Docker Desktop，您就可以在那里看到它了。</font>

<!-- 这是一张图片，ocr 内容为： -->
![](https://cdn.nlark.com/yuque/0/2025/png/54784325/1766024060385-ce2a8615-1292-4ebe-8797-d139e0cfec45.png)

_<font style="color:rgb(51, 51, 51);">Docker Desktop 中提供了 MongoDB 镜像。</font>_

<font style="color:rgb(51, 51, 51);">让我们使用</font>`<font style="color:rgb(51, 51, 51);background-color:rgb(243, 244, 244);">docker run</font>`<font style="color:rgb(51, 51, 51);">命令运行我们的 MongoDB 镜像。</font>

docker run -d -p 27017:27017 --name mongo-server-local mongo: latest

<!-- 这是一张图片，ocr 内容为： -->
![](https://cdn.nlark.com/yuque/0/2025/png/54784325/1766024060703-889a8ce7-32f9-4875-b8dc-0c5055d2d737.png)

_<font style="color:rgb(51, 51, 51);">在 Docker 中运行 MongoDB 的示例输出</font>_

<font style="color:rgb(51, 51, 51);">我们已成功运行 Docker 镜像。现在我们可以在 Docker Desktop 上看到容器正在运行。</font>

<!-- 这是一张图片，ocr 内容为： -->
![](https://cdn.nlark.com/yuque/0/2025/png/54784325/1766024062272-c0519d1d-09be-442b-8953-de383c7f228b.png)

_<font style="color:rgb(51, 51, 51);">在 Docker Desktop 中运行的 MongoDB 容器</font>_

<font style="color:rgb(51, 51, 51);">所以，MongoDB 服务器正在您的机器上运行。让我们在浏览器中确认一下。在浏览器中访问</font>[<font style="color:rgb(65, 131, 196);">http://localhost:27017</font>](http://localhost:27017/)<font style="color:rgb(51, 51, 51);">，您应该能够看到如下截图所示的消息：</font>

<!-- 这是一张图片，ocr 内容为： -->
![](https://cdn.nlark.com/yuque/0/2025/png/54784325/1766024063093-21e63ff2-3511-48c5-83e6-a7fcf6ec35c5.png)

_<font style="color:rgb(51, 51, 51);">使用 Docker 运行 MongoDB 服务器时，示例输出为“看起来您正在尝试通过 HTTP 在原生驱动程序端口上访问 MongoDB”。</font>_

<font style="color:rgb(51, 51, 51);">很有意思，对吧？</font>

<font style="color:rgb(51, 51, 51);">我们可以随时使用 Docker 停止/启动 MongoDB 服务器。</font>

### <font style="color:rgb(51, 51, 51);">重要提示</font>
1. <font style="color:rgb(51, 51, 51);">不建议将 Docker 用作生产环境的数据库。</font>
2. <font style="color:rgb(51, 51, 51);">不要将 Docker 数据库用于大规模应用程序。</font>

## <font style="color:rgb(51, 51, 51);">什么是docker-compose？</font>
<font style="color:rgb(51, 51, 51);">让我们回到 docker-compose 上来。</font>

<font style="color:rgb(51, 51, 51);">Docker Compose 是一款可用于定义和共享多容器应用程序的工具。这意味着您可以使用单个源代码运行包含多个容器的项目。</font>

<font style="color:rgb(51, 51, 51);">例如，假设您正在构建一个同时使用 NodeJS 和 MongoDB 的项目。您可以创建一个镜像，将这两个容器作为服务启动——无需分别启动它们。</font>

<font style="color:rgb(51, 51, 51);">很有意思，对吧？这正好解决了我在文章开头提出的问题。</font>

<font style="color:rgb(51, 51, 51);">为了实现这一点，我们需要定义一个</font>`<font style="color:rgb(51, 51, 51);background-color:rgb(243, 244, 244);">docker-compose.yml</font>`<font style="color:rgb(51, 51, 51);">。</font>

### <font style="color:rgb(51, 51, 51);">docker-compose.yml 文件</font>
<font style="color:rgb(51, 51, 51);">Compose 文件是一个 YML 文件，用于定义 Docker 容器的服务、网络和卷。Compose 文件格式有多个版本——1、2、2.x 和 3.x。</font>

<font style="color:rgb(51, 51, 51);">本文使用的是版本 3。</font>

```plain
version: '3'
services:
  app:
    image: node:latest
    container_name: app_main
    restart: always
    command: sh -c "yarn install && yarn start"
    ports:
      - 8000:8000
    working_dir: /app
    volumes:
      - ./:/app
    environment:
      MYSQL_HOST: localhost
      MYSQL_USER: root
      MYSQL_PASSWORD: 
      MYSQL_DB: test
  mongo:
    image: mongo
    container_name: app_mongo
    restart: always
    ports:
      - 27017:27017
    volumes:
      - ~/mongo:/data/db
volumes:
  mongodb:
```

<font style="color:rgb(51, 51, 51);">让我们把上面的代码拆解开来，逐段理解：</font>

+ `<font style="color:rgb(51, 51, 51);background-color:rgb(243, 244, 244);">version</font>`<font style="color:rgb(51, 51, 51);">指的是 docker-compose 版本（最新 3 版）</font>
+ `<font style="color:rgb(51, 51, 51);background-color:rgb(243, 244, 244);">services</font>`<font style="color:rgb(51, 51, 51);">定义了我们需要运行的服务</font>
+ `<font style="color:rgb(51, 51, 51);background-color:rgb(243, 244, 244);">app</font>`<font style="color:rgb(51, 51, 51);">是您的某个容器的自定义名称。</font>
+ `<font style="color:rgb(51, 51, 51);background-color:rgb(243, 244, 244);">image</font>`<font style="color:rgb(51, 51, 51);">我们需要提取的图像。这里我们使用</font>`<font style="color:rgb(51, 51, 51);background-color:rgb(243, 244, 244);">node:latest</font>`<font style="color:rgb(51, 51, 51);">和</font>`<font style="color:rgb(51, 51, 51);background-color:rgb(243, 244, 244);">mongo</font>`<font style="color:rgb(51, 51, 51);">。</font>
+ `<font style="color:rgb(51, 51, 51);background-color:rgb(243, 244, 244);">container_name</font>`<font style="color:rgb(51, 51, 51);">是每个容器的名称</font>
+ `<font style="color:rgb(51, 51, 51);background-color:rgb(243, 244, 244);">restart</font>`<font style="color:rgb(51, 51, 51);">启动/重启服务容器</font>
+ `<font style="color:rgb(51, 51, 51);background-color:rgb(243, 244, 244);">port</font>`<font style="color:rgb(51, 51, 51);">定义运行容器的自定义端口</font>
+ `<font style="color:rgb(51, 51, 51);background-color:rgb(243, 244, 244);">working_dir</font>`<font style="color:rgb(51, 51, 51);">是服务容器的当前工作目录</font>
+ `<font style="color:rgb(51, 51, 51);background-color:rgb(243, 244, 244);">environment</font>`<font style="color:rgb(51, 51, 51);">定义环境变量，例如数据库凭据等。</font>
+ `<font style="color:rgb(51, 51, 51);background-color:rgb(243, 244, 244);">command</font>`<font style="color:rgb(51, 51, 51);">这是运行该服务的命令。</font>

### <font style="color:rgb(51, 51, 51);">如何运行多容器</font>
<font style="color:rgb(51, 51, 51);">我们需要使用 docker build 构建多容器系统。</font>

docker compose build

<font style="color:rgb(51, 51, 51);">构建成功后，我们可以使用命令运行容器</font>`<font style="color:rgb(51, 51, 51);background-color:rgb(243, 244, 244);">up</font>`<font style="color:rgb(51, 51, 51);">。</font>

docker compose up

<font style="color:rgb(51, 51, 51);">如果想以分离模式运行容器，只需使用该</font>`<font style="color:rgb(51, 51, 51);background-color:rgb(243, 244, 244);">-d</font>`<font style="color:rgb(51, 51, 51);">标志即可。</font>

docker compose up -d

<!-- 这是一张图片，ocr 内容为： -->
![](https://cdn.nlark.com/yuque/0/2025/png/54784325/1766024062417-b3ed4cdc-56c1-43bb-b36d-079de4356143.png)

_<font style="color:rgb(51, 51, 51);">使用 docker-compose 以分离模式运行多个容器的示例输出</font>_

<font style="color:rgb(51, 51, 51);">好了，一切就绪。容器已启动并运行。我们来检查一下容器列表。</font>

docker compose ps

<!-- 这是一张图片，ocr 内容为： -->
![](https://cdn.nlark.com/yuque/0/2025/png/54784325/1766024063082-c795e2a9-c37a-4dba-b5d5-eaeb13843d13.png)

_<font style="color:rgb(51, 51, 51);">列出正在运行的容器服务的示例输出</font>_

<font style="color:rgb(51, 51, 51);">太好了，我们可以看到有两个容器同时在运行。</font>

<!-- 这是一张图片，ocr 内容为： -->
![](https://cdn.nlark.com/yuque/0/2025/png/54784325/1766024065643-a6043a96-d5fe-457d-a454-474c468f3cdd.png)

_<font style="color:rgb(51, 51, 51);">使用 Docker 运行 Node.js 服务的示例输出</font>_

<!-- 这是一张图片，ocr 内容为： -->
![](https://cdn.nlark.com/yuque/0/2025/png/54784325/1766024067382-5f515374-9629-4ad1-8eb9-7c2e04886f7c.png)

_<font style="color:rgb(51, 51, 51);">使用 Docker 运行 MongoDB 服务的示例输出</font>_

<font style="color:rgb(51, 51, 51);">要查看 MongoDB 中的数据，您需要安装 MongoDB Compass。</font>

<font style="color:rgb(51, 51, 51);">这是截图。</font>

<!-- 这是一张图片，ocr 内容为： -->
![](https://cdn.nlark.com/yuque/0/2025/png/54784325/1766024065529-72cb72a5-a1da-4103-a54d-7cc97809b620.png)

_<font style="color:rgb(51, 51, 51);">MongoDB Compass 中的 MongoDB 服务器视图</font>_

### <font style="color:rgb(51, 51, 51);">LoggerConfig 日志器配置</font>
<font style="color:rgb(51, 51, 51);">关于 log4j2，它是在代码内部记录日志的库，有两个关键信息 appender 和 logger 。</font>

<font style="color:rgb(51, 51, 51);">appender 用于确定日志保存在哪个目标位置，logger 用于配置日志的级别和范围。</font>

<font style="color:rgb(51, 51, 51);">索引和集合 : TTL indexs and Limited Sized Collections。</font>

<font style="color:rgb(51, 51, 51);">日志分级：Info / Debug / Error , 除了日志分级，LoggerConfig 还包含全局控制器和替换器。</font>

<font style="color:rgb(51, 51, 51);">log4j2.xml 位于 resource 文件夹下：</font>

```plain
<?xml version="1.0" encoding="UTF-8"?>
<!-- Extra logging related to initialization of Log4j. 
 Set to debug or trace if log4j initialization is failing. -->
<Configuration status="warn">
    <Appenders>
        <!-- Console appender configuration -->
        <Console name="console" target="SYSTEM_OUT">
            <PatternLayout
                pattern="%d{yyyy-MM-dd HH:mm:ss} %-5p %c{1}:%L - %m%n" />
        </Console>

    </Appenders>

    <Loggers>
        <!-- Root logger referring to console appender -->
        <Root level="info" additivity="false">
            <AppenderRef ref="console" />
        </Root>

    </Loggers>

</Configuration>

```

<font style="color:rgb(51, 51, 51);">下面是关于 logger 的示例：</font>

```plain
Logger logger = LogManager.getLogger(MyClass.class)
Logger rootLogger = Logmanager.getRootLogger();
logger.info("Some Message");
```

### <font style="color:rgb(51, 51, 51);">Core Log4j2 API</font>
<font style="color:rgb(51, 51, 51);">让我们编写一个Java类，并编写一些日志语句来验证日志是否同时出现在控制台和日志文件中。将不同的日志级别记录到不同的日志中。</font>

```plain
package com.qingyunyouxiao.mdsp;

import org.apache.logging.log4j.Logger;
import org.apache.logging.log4j.LogManager;

public class main {
    
    private static final Logger logger = LogManager.getLogger(main.class);

    public static void main (final String... args) {
        logger.debug("Debug Message");
        logger.info("Info Message");
        logger.error("Error Message", new NullPointerException("Null Error"));
    }

}
```

