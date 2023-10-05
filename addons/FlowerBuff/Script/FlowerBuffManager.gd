class_name FlowerBuffManager
extends Node

signal minus_time

@export var target:Node
@export var buff_list:Array[FlowerBaseBuff] = []

var timer:Timer

func _ready() -> void:
    if not target:
        assert(false, "No target node.")
    
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
        
        minus_time.connect(i.minus_all_time)
        i.removed.connect(remove_buff.bind(i))

func add_buff(_buff:FlowerBaseBuff) -> void:
    buff_list.append(_buff)
    compute()

func remove_buff(_buff:FlowerBaseBuff) -> void:
    if _buff.is_connected("removed", remove_buff):
        _buff.disconnect("removed", remove_buff)
    if is_connected("minus_time", _buff.minus_all_time):
        disconnect("minus_time", _buff.minus_all_time)
    
    if _buff in buff_list:
        buff_list.erase(_buff)
        _buff = null

func compute() -> void:
    for _buff in buff_list:
        if not _buff:
            return
        update_buff_tree()
        _buff.activate(target)
