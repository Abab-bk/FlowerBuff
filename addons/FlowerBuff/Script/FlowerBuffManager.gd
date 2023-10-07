class_name FlowerBuffManager
extends Node

signal minus_time
signal a_buff_activated(buff:FlowerBaseBuff)
signal a_buff_finished(buff:FlowerBaseBuff)
signal a_buff_removed(buff:FlowerBaseBuff)
signal compute_values

@export var target:Node
@export var compute_data:FlowerData
@export var output_data:FlowerData
@export var buff_list:Array[FlowerBaseBuff] = []
#@export var tags:Array[String]

var timer:Timer
var computer:FlowerComputer

# TODO：优先级
# TODO：tags

func _ready() -> void:
    if not target:
        assert(false, "No target node.")
    
    computer = FlowerComputer.new()
    add_child(computer)
    computer.output_data_change.connect(func():
        output_data = computer.output_data
#        print("更新 output_data 完毕")
        )
    
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
        i.activated.connect(func():a_buff_activated.emit())
        i.finished.connect(func():a_buff_finished.emit())
        i.computed_values.connect(func():compute_values.emit())
        i.removed.connect(func():a_buff_removed.emit())

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
    var id_counter := 1  # 用于生成新的不相同ID的计数器
    var processed_ids := []  # 已处理的ID列表

    for _buff in buff_list:
        for _value in _buff.compute_values:
            if computer.all_data.has(_value.id):
                # 处理存在相同ID的情况
                var new_id := _value.id + "_" + str(id_counter)  # 生成新的不相同ID
                
                while new_id in processed_ids:  # 确保新ID不会重复
                    id_counter += 1
                    new_id = _value.id + "_" + str(id_counter)
                
                _value.id = new_id  # 更新值的ID
                processed_ids.append(new_id)  # 将新ID添加到已处理列表中

            computer.all_data[_value.id] = _value
    
    # 然后加入进去origin_data
    computer.origin_data = compute_data
    # 先后计算
    computer.compute()

func compute() -> void:
    for _buff in buff_list:
        if not _buff:
            return
        update_buff_tree()
        _buff.activate(target, compute_data, output_data)
        # 给用户用的信号
        a_buff_activated.emit(_buff)
