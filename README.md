# FlowerBuff

非常牛逼的buff解决方案。

> 五星上将麦克阿瑟曾说过：如果我在上战场之前看到了FlowerBuff（纯正伦敦腔），那么恐怕.....

### 安装

1. 下载本项目

2. 将 addons/FlowerBuff 放进你的项目中的 addons 文件夹

3. 重新加载项目

4. 开始使用，无需激活插件

### 快速开始

##### 创建 buff 类

- 新建脚本 SimpleBuff.gd：

```gdscript
class_name SimpleBuff
extends FlowerBaseBuff # 继承自 FlowerBaseBuff

# 复写 take_effect() 函数，此为buff激活时执行代码
func take_effect() -> void:
    # do something

# 复写 un_take_effect() 函数，此为buff销毁时执行代码
    # do something
```

- 在场景中添加节点 ”FlowerBuffManager“

- 修改 FlowerBuffManager 的 target 属性，该值为 buff 应用的对象

- 修改 buff_list，在其中加入自定义的 Buff

- 调用 ```FlowerBuffManager.compute()``` 来计算buff

### 属性说明

##### FlowerBaseBuff

- name：buff名称

- desc：buff描述

- repeat：buff是否重复（即冷却后是否再次执行，为false则执行完毕后销毁）

- infinite：是否永不自动销毁

- prepare_time：准备时间，单位秒，在这个时间过后才会执行buff

- active_time：持续时间，单位秒，在这个时间过后buff执行完毕

- cooldown_time：冷却时间，单位秒

- actor：FlowerBuffManager 的 target 属性，buff 应用的对象


