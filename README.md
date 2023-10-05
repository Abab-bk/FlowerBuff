好的,我尝试直接给出修改后的 README 内容:

# FlowerBuff

一个简单易用的 Godot buff 插件

## 目录

- [简介](#简介)
- [安装](#安装)
- [快速上手](#快速上手)
- [API文档](#API文档) 
- [常见问题](#常见问题)
- [反馈与贡献](#反馈与贡献)

## 简介

FlowerBuff 可以轻松为 Godot 游戏添加 buff 效果。主要功能:

- 支持自定义 buff 逻辑
- 自动处理 buff 应用、持续、冷却等状态
- 简单的 API 使用
- 良好的扩展性

## 安装

1. 下载本项目 release
2. 将 addons/FlowerBuff 放进你的项目中的 addons 文件夹
3. 重新加载项目

需要 Godot 3.x 版本。

## 快速上手

##### 创建 buff 类

新建一个继承自 FlowerBaseBuff 的脚本:

```gdscript
class_name SimpleBuff 
extends FlowerBaseBuff

func take_effect():
   print("Buff启动")

func un_take_effect():
   print("Buff结束")
```

##### 应用 buff

在场景中添加 FlowerBuffManager 节点,设置 target 属性,然后在 buff_list 中添加自定义的 buff:

```gdscript
# 使用代码
FlowerBuffManager.add_buff(_buff:FlowerBaseBuff)
```

调用 `FlowerBuffManager.compute()` 来处理 buff 逻辑。

## API文档

### FlowerBaseBuff

- name：buff名称
- desc：buff描述
- repeat：buff是否重复（即冷却后是否再次执行，为false则执行完毕后销毁）
- infinite：是否永不自动销毁- prepare_time：准备时间，单位秒，在这个时间过后才会执行buff
- active_time：持续时间，单位秒，在这个时间过后buff执行完毕
- cooldown_time：冷却时间，单位秒
- actor：FlowerBuffManager 的 target 属性，buff 应用的对象

## 常见问题

TOD
