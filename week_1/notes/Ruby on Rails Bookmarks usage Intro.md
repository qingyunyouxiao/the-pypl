关于 Ruby on Rails 中的“书签”，根据搜索结果来看，这个词实际上指向**三种完全不同的功能场景**。为避免混淆，下面将它们分开说明：

---

## 场景一：用户“收藏”功能（最常见的需求）
如果你是想实现**“用户可以对文章、商品等内容添加/取消收藏”**，这是典型的**多对多关联**操作。可以使用 `bookmark_system` gem 快速实现 。

**📦 安装与初始化**
```ruby
# Gemfile
gem 'bookmark_system'

# 执行安装命令
$ bundle
$ rails g bookmark_system
```

**🛠️ 模型配置**
```ruby
# app/models/post.rb
class Post < ApplicationRecord
  act_as_bookmarkee      # 表示“可以被收藏”
end

# app/models/user.rb
class User < ApplicationRecord
  act_as_bookmarker      # 表示“可以收藏别人”
end
```

**🎯 核心操作（控制器/视图中使用）**
```ruby
# 用户收藏一篇文章
user.bookmark(post)

# 用户取消收藏
user.unbookmark(post)

# 切换收藏状态（收藏/取消收藏一键切换）
user.toggle_bookmark(post)

# 判断是否已收藏
user.bookmarks?(post)    # => true / false

# 查询某篇文章被哪些用户收藏了
post.bookmarkers_by(User)

# 查询某个用户收藏了哪些文章
user.bookmarkees_by(Post)
```
**⚠️ 注意**：该 gem 适用于 Rails 4/5，新版 Rails 可能需要自行调整或参考其源码 。

---

## 场景二：社会化分享按钮
如果你想要的是**“给第三方网站（微博、Facebook等）添加分享链接”**，这是往页面里放**分享书签**按钮。

**📦 安装 `rubymarks` gem**
```ruby
# Gemfile
gem 'Floppy-rubymarks', :lib => 'rubymarks', :source => 'http://gems.github.com'
```


**🖼️ 视图中的用法**
```erb
<!-- 生成分享到Twitter的链接 -->
<%= bookmark_tag :twitter, "https://example.com", title: "看这篇文章" %>

<!-- 只生成URL，不生成<a>标签 -->
<%= bookmark_url :facebook, "https://example.com" %>
```

**支持的服务商**：`:facebook`, `:digg`, `:delicious`, `:stumbleupon`, `:twitter`, `:reddit`, `:google`, `:myspace`, `:tinyurl` 等 。

---

## 场景三：浏览器书签小程序（Bookmarklet）
这是指**从浏览器工具栏一键执行JS脚本**，通常用于“收藏当前网页到自己的Rails应用”。

**✅ Rails 中的推荐做法 ：**
1.  **使用视图 partial 存放 JavaScript 代码**（注意必须生成**绝对路径**，因为书签小程序会在其他网站运行）。
2.  **利用 `link_to` 自动转义**，避免引号错误。

```erb
<!-- app/views/shared/_bookmarklet.js.erb -->
(function(){
  var url = encodeURIComponent(location.href);
  var title = encodeURIComponent(document.title);
  location.href = '<%= bookmarks_url %>?url=' + url + '&title=' + title;
})();
```

```erb
<!-- 放置书签按钮的页面 -->
<%= link_to "添加到我的收藏", render('shared/bookmarklet'), id: "bookmarklet" %>
```

**💡 原理**：将 JS 代码作为 `href` 属性的值，点击时在当前页面执行脚本，并将数据发回你的 Rails 应用。

---

## 总结：先确定你要的是哪一种？
| 需求                   | 对应方案              | 推荐程度       |
| ---------------------- | --------------------- | -------------- |
| 网站内的“收藏/赞”功能  | `bookmark_system` gem | ⭐⭐⭐            |
| 分享到微博/脸书等外站  | `rubymarks` gem       | ⭐⭐（项目较老） |
| 浏览器端的“收藏到本站” | 自定义 Bookmarklet    | ⭐⭐⭐⭐           |

如果你能补充说明具体是想做“用户收藏文章”还是“分享按钮”，我可以针对你的业务场景进一步细化代码示例。