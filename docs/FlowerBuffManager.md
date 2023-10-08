# FlowerBuffManager

FlowerBaseBuff 是一个节点，是 FlowerBuff 与其他节点交互的粘合剂。

## 属性

- target：目标节点

- compute_data：用于 buff 计算的值

- output_data：计算后生成的值，由于 output_data 的存在，不会危及原始值（compute_data），无需手动填写

- buff_list：存在的 buff 列表


