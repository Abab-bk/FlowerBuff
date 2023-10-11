# FlowerBuff

> 

## 🤔这是什么？🤔

FlowerBuff 是一个为 Godot 开发的强大、简单、易用的 Buff 系统插件。

## ✨特性✨

- 支持自定义 buff 逻辑
- 自动处理 buff 应用、持续、冷却等状态
- 简单的 API 使用
- 良好的扩展性

## 🫡安装🫡

1. clone 本项目
2. 将 addons/FlowerBuff 放进你的项目中的 addons 文件夹
3. 重新加载项目

> 需要 Godot 4.x 版本。

## 快速上手

### 创建 buff 类

新建一个继承自 FlowerBaseBuff 的脚本:

```gdscript
class_name SimpleBuff 
extends FlowerBaseBuff

func take_effect():
   print("Buff启动")

func un_take_effect():
   print("Buff结束")
```

### 应用 buff

在场景中添加 FlowerBuffManager 节点,设置 target 属性,然后在 buff_list 中添加自定义的 buff:

```gdscript
# 使用代码
FlowerBuffManager.add_buff(_buff:FlowerBaseBuff)
```

调用 `FlowerBuffManager.compute()` 来处理 buff 逻辑。

## API文档

你可以在 [这里](https://btother.gitbook.io/flowerbuff/) 查看更多文档。

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
