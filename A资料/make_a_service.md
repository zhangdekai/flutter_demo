## 使用 Node.js 和 Express 框架

Express 是一个流行的 Node.js Web 应用框架，可用于快速搭建服务器。

步骤
初始化项目：创建一个新的项目目录，在该目录下打开命令行工具，运行以下命令初始化项目：

```
npm init -y
```

安装 Express：运行以下命令安装 Express：

```
npm install express

```

编写 JavaScript 代码：创建一个 JavaScript 文件（例如 server.js），并编写以下代码：

```javascript

const express = require('express');
const app = express();

// 定义一个路由，当访问根路径时返回 JSON 数据
app.get('/', (req, res) => {
const data = {
"message": "Hello, World!",
"status": "success"
};
res.json(data);
});

// 启动服务器
const port = 3000;
app.listen(port, () => {
console.log(`Server is running on port ${port}`);
});

```

运行服务器：在命令行中运行以下命令启动服务器：
``
node server.js

```
测试服务器：打开浏览器，访问 http://127.0.0.1:3000，你将看到返回的 JSON 数据。




