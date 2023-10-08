# FlowerBaseBuff

FlowerBaseBuff 是一种资源，在游戏中，它是 ”Buff“。

## 属性

* name：buff名称
* desc：buff描述
* repeat：buff是否重复（即冷却后是否再次执行，为false则执行完毕后销毁）
* infinite：是否永不自动销毁- prepare_time：准备时间，单位秒，在这个时间过后才会执行buff
* compute_values： 复杂计算值
* active_time：持续时间，单位秒，在这个时间过后buff执行完毕
* cooldown_time：冷却时间，单位秒
* actor：FlowerBuffManager 的 target 属性，buff 应用的对象


