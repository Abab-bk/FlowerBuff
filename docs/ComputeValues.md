# ComputeValues

FlowerBaseBuff 是一种资源，它是 FlowerBaseBuff 的复杂计算类型。

## 属性

* id：buff名称
* type：该计算类型的计算类型，其中 Complex 前缀的可以使用公式计算
* value：该计算类型的值，在 Complex 类型下无效
* formual：该计算类型的公式，仅在 Complex 类型下有效
* target_property： 该计算类型的目标属性，是该计算要应用到的属性

对于 target_property，假如该值为：hp，实际上是 FlowerBuffManager 的 compute_data 属性中的值。


