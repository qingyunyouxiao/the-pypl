# Rails Routing



这是Ruby on Rails框架的**路由系统官方指南**，核心是讲解如何通过 `config/routes.rb` 文件配置 URL 与应用程序逻辑的映射关系，让 HTTP 请求能正确路由到对应的控制器动作（方法），同时提供高效的路径/URL 生成工具。

简单来说，Rails 路由就像应用程序的“交通指挥官”——它接收用户的 URL 请求（比如 `GET /users/17`），匹配到对应的业务逻辑（比如 `UsersController` 的 `show` 方法），还能帮开发者自动生成路径（避免硬编码 URL），同时支持复杂场景的灵活配置。



### 核心内容拆解

#### 1. 路由的核心作用

- **请求匹配**：将 HTTP 请求（结合 URL 路径 + HTTP 动词，如 `GET`/`POST`/`DELETE`）映射到对应的控制器动作。
  例：`DELETE /photos/17` 会匹配到 `PhotosController` 的 `destroy` 动作，同时传递参数 `{ id: '17' }`。
- **路径生成**：自动生成路径/URL 助手（如 `user_path`/`user_url`），避免在视图/控制器中硬编码 URL，后续修改路由时无需全局替换。
  例：`user_path(@user)` 会生成 `/users/17`（相对路径），`user_url(@user)` 会生成 `https://example.com/users/17`（绝对 URL）。



#### 2. 两种核心路由类型

Rails 路由主要分为「资源路由」和「非资源路由」，其中**资源路由是 Rails 的核心设计**（遵循 RESTful 规范）。

##### （1）资源路由（推荐优先使用）

针对数据模型（如用户、照片、文章）的 CRUD 操作，用 `resources` 一行代码即可生成 7 个常用路由（对应 `index`/`show`/`new`/`create`/`edit`/`update`/`destroy` 动作），无需逐个编写。

| HTTP 动词 | 路径             | 控制器动作     | 用途               |
| --------- | ---------------- | -------------- | ------------------ |
| GET       | /photos          | photos#index   | 显示所有照片列表   |
| GET       | /photos/new      | photos#new     | 渲染“新建照片”表单 |
| POST      | /photos          | photos#create  | 提交表单创建新照片 |
| GET       | /photos/:id      | photos#show    | 显示单个照片详情   |
| GET       | /photos/:id/edit | photos#edit    | 渲染“编辑照片”表单 |
| PATCH/PUT | /photos/:id      | photos#update  | 提交表单更新照片   |
| DELETE    | /photos/:id      | photos#destroy | 删除照片           |

**衍生用法**：

- 单数资源：用 `resource`（而非 `resources`），适用于“全局唯一”的资源（如购物车），生成 6 个无 `index` 动作的路由。
- 嵌套资源：处理模型间的关联关系（如“杂志下的广告”），用嵌套语法生成带父级 ID 的路径（如 `/magazines/:magazine_id/ads`）。
- 浅层嵌套：避免深层嵌套的复杂路径（如 `/articles/1/comments/2` 简化为 `/comments/2`），通过 `shallow: true` 实现。
- 命名空间：给控制器分组（如 admin 后台），用 `namespace :admin` 生成带 `/admin` 前缀的路径（如 `/admin/articles`）。

##### （2）非资源路由（灵活场景使用）

适用于不遵循 CRUD 规范的 URL（如旧系统兼容、特殊功能页面），需手动指定路径与动作的映射。

**关键特性**：

- 动态段：用 `:参数名` 捕获 URL 中的变量（如 `get "/photos/:id/:user_id"`，可通过 `params[:id]`/`params[:user_id]` 获取值）。
- 静态段：URL 中固定的部分（如 `get "/photos/:id/with_user/:user_id"`，`with_user` 是静态段）。
- 通配符段：用 `*` 捕获 URL 剩余部分（如 `get "photos/*other"`，`/photos/long/path` 会被 `params[:other]` 捕获为 `long/path`）。
- 重定向：用 `redirect` 实现 URL 跳转（如 `get "/stories", to: redirect("/articles")`）。



#### 3. 路由的高级配置

- **约束**：限制路由匹配规则，比如：

- 段约束：强制 `id` 为 5 位字母数字（`get "/photos/:id", constraints: { id: /[A-Z]\d{5}/ }`）。
- 请求约束：只匹配特定子域（`get "/photos", constraints: { subdomain: "admin" }`）。

- **命名路由**：用 `as:` 自定义路径助手名称（如 `get "/exit", to: "sessions#destroy", as: :logout`，生成 `logout_path` 助手）。
- **默认参数**：设置路由默认值（如 `get "/photos/:id", defaults: { format: "jpg" }`，默认返回 JPG 格式）。
- **自定义资源路由**：修改默认生成的路径/助手，比如：

- 重命名 `new`/`edit` 路径（`path_names: { new: "make", edit: "change" }`）。
- 覆盖路由助手前缀（`as: "admin_photos"` 生成 `admin_photos_path`）。
- 重命名默认参数 `id`（`param: :identifier`，用 `params[:identifier]` 替代 `params[:id]`）。



#### 4. 路由的检查与测试

- 列出现有路由：终端执行 `bin/rails routes`（或访问开发环境的 `/rails/info/routes`），查看所有路由的匹配规则、助手名称。
- 搜索路由：用 `bin/rails routes -g 关键词`（如 `-g admin`）筛选特定路由。
- 测试路由：用 Rails 内置断言（`assert_generates`/`assert_recognizes`/`assert_routing`）验证路由是否正确匹配/生成。



#### 5. 大型应用的路由拆分

当 `config/routes.rb` 过于庞大时，用 `draw` 方法拆分到多个文件（如 `config/routes/admin.rb`），保持代码整洁。



### 核心目标

这篇指南的目的是帮助 Rails 开发者：

1. 理解路由的工作原理，快速配置符合 RESTful 规范的资源路由；
2. 灵活应对复杂场景（如嵌套资源、URL 重定向、路由约束）；
3. 避免硬编码 URL，利用路由助手提高开发效率和可维护性；
4. 正确检查、测试路由，确保请求能准确映射到业务逻辑。

如果需要实际开发中配置某类路由（如嵌套资源、Admin 命名空间），可以基于指南中的示例直接修改使用。