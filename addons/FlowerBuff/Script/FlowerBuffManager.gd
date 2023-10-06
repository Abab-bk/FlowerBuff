class_name FlowerBuffManager
extends Node

signal minus_time

@export var target:Node
@export var compute_data:FlowerData
@export var output_data:FlowerData
@export var buff_list:Array[FlowerBaseBuff] = []
@export var tags:Array[String]

var timer:Timer
var computer:FlowerComputer

# TODO：触发条件、优先级
# TODO：触发条件细分： 1. 自动触发 2. 条件不满足自动取消 3. 条件满足自动触发
# TODO：计算流水线 - 1. more流水线 2. inc流水线
# TODO：循环次数
# 先把需要计算的数据加到一个字典

func _ready() -> void:
    if not target:
        assert(false, "No target node.")
    
    computer = FlowerComputer.new()
    add_child(computer)
    computer.output_data_change.connect(func():output_data = computer.output_data)
    
    timer = Timer.new()
    add_child(timer)
    timer.wait_time = 1
    timer.autostart = false
    timer.one_shot = false
    timer.timeout.connect(func():minus_time.emit())
    
    update_buff_tree()
    timer.start()

func update_buff_tree() -> void:
    for i in buff_list:
        if not i:
            return
        
        if is_connected("minus_time", i.minus_all_time):
#            print("已经链接")
            continue
        if i.is_connected("removed", remove_buff):
#            print("已经连接remove信号")
            continue
        if i.is_connected("computed_values", computed_values):
            continue
        
        minus_time.connect(i.minus_all_time)
        i.removed.connect(remove_buff.bind(i))
        i.computed_values.connect(computed_values)

func add_buff(_buff:FlowerBaseBuff) -> void:
    buff_list.append(_buff)
    compute()

func remove_buff(_buff:FlowerBaseBuff) -> void:
    if _buff.is_connected("removed", remove_buff):
        _buff.disconnect("removed", remove_buff)
    if _buff.is_connected("computed_values", computed_values):
        _buff.disconnect("computed_values", computed_values)
    if is_connected("minus_time", _buff.minus_all_time):
        disconnect("minus_time", _buff.minus_all_time)
    
    if _buff in buff_list:
        buff_list.erase(_buff)
        _buff = null

func computed_values() -> void:
    # 要先把buff给分类
    for _buff in buff_list:
        for _value in _buff.compute_values:
            if _value.type == FlowerConst.COMPUTE_TYPE.MORE:
                # more 类型
                computer.more_data[_value.id] = _value
            elif _value.type == FlowerConst.COMPUTE_TYPE.INCREASE:
                # inc 类型
                computer.increase_data[_value.id] = _value
            elif _value.type == FlowerConst.COMPUTE_TYPE.COMPLEX_INCREASE:
                computer.complex_increase_data[_value.id] = _value
    # 然后加入进去origin_data
    computer.origin_data = compute_data
    # 先后计算
    computer.compute()
    print("计算完毕")

func compute() -> void:
    for _buff in buff_list:
        if not _buff:
            return
        update_buff_tree()
        _buff.activate(target)
