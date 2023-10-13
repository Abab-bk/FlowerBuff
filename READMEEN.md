FlowerBuff
==========

Official release! Current version: v0.0.2!

![](Cover.png)

## 🤔What is this?🤔

FlowerBuff is a powerful, simple and easy to use Buff system plugin for Godot.

## ✨Features✨

* Support custom buff logic
* Automatically handle buff application, duration, cooldown etc.
* Simple API usage
* Good extensibility

🫡Installation🫡
----------------

1. Clone this project
2. Put addons/FlowerBuff into the addons folder in your project
3. Reload the project

> Requires Godot 4.x version.

⏱️Quick Start⏱️
-----------

### Create a buff class

Create a script inheriting from FlowerBaseBuff:

```gdscript
class_name SimpleBuff 
extends FlowerBaseBuff

func take_effect():
   print("Buff Start")

func un_take_effect():
   print("Buff End")
```

### Apply buff

Add a FlowerBuffManager node in the scene, set the target property, then add custom buffs in buff_list:

Use gdscript :

```gdscript
# 使用代码
FlowerBuffManager.add_buff(_buff:FlowerBaseBuff)
```

Call `FlowerBuffManager.compute()` to process buff logic.

## 📃Documentation📃

You can view more docs [here](https://btother.gitbook.io/flowerbuff/).

## 🫥Change Log🫥

v 0.0.2：

* Add a signal to be emitted when the computation is complete: FlowerBuffManager.compute_ok

* Fixed: automatically call ```compute()``` after removing buff (after ```remove_buff()```)
