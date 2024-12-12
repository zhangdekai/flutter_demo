# FVM 配置

参考官网安装 [官网](https://fvm.app/documentation/getting-started)

### 常用Command：

* fvm use 3.19.4
* fvm global 3.13.9
* fvm list or fvm ls
* fvm remove 2.2.3
* fvm install 3.19.6
* dart pub global activate fvm (zsh: command not found: fvm(确认fvm 安装过了) )

macbook M2 系列电脑

命令默认是 zsh

source .zshrc

.zshrc 中 修改path
export PATH="$PATH:/Users/zhangdekai/fvm/default/bin"（在已配置好的环境中需要修改）

之前默认 PATH="$PATH:/Users/zhangdekai/development/flutter/bin".

系统会默认走设置的path。





