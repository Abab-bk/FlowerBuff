class_name FlowerBaseBuff
extends Resource

signal activated
signal finished
signal removed
signal computed_values

@export var name:String = ""
@export var desc:String = ""
@export var repeat:bool = false
@export var infinite:bool = false
#@export var tigger:FlowerTigger
@export var compute_values:Array[FlowerComputeData] # = [FlowerComputeData.new("测试", "HP", FlowerConst.COMPUTE_TYPE.MORE, 3.0)]
@export var prepare_time:int = 0:
    set(v):
        prepare_time = v
        prepare_time_temp = prepare_time
@export var active_time:int = 0:
    set(v):
        active_time = v
        active_time_temp = active_time
@export var cooldown_time:int = 0:
    set(v):
        cooldown_time = v
        cooldown_time_temp = cooldown_time

var prepare_time_temp:int = 0
var active_time_temp:int = 0
var cooldown_time_temp:int = 0

var actor:Node
var origin_data:FlowerData
var output_data:FlowerData

var current_state:STATE = STATE.PREPARE

enum STATE {
    RUNNING,
    PREPARE,
    COOLDOWN,
}

func start() -> void:
    current_state = STATE.PREPARE

func minus_all_time() -> void:
    minus_prepare_time()
    minus_active_time()
    minus_cooldown_time()

func minus_active_time() -> void:
    if not current_state == STATE.RUNNING:
        return
    
    if infinite:
        return
    
    if active_time_temp <= 0:
        # 持续时间耗尽 | 开始检测冷却
        active_time_temp = active_time
        un_take_effect()
        if not repeat:
#            print("不是重复buff，应该退出")
            remove()
            return
#        print("是重复buff，应该继续：", repeat)
        current_state = STATE.COOLDOWN
    
    active_time_temp -= 1

func minus_cooldown_time() -> void:
    if not current_state == STATE.COOLDOWN:
        return
    
    if infinite:
        return
    
#    print("冷却中，余剩：", cooldown_time_temp)
    
    if cooldown_time_temp <= 0:
        # 冷却结束 | 开始准备
        cooldown_time_temp = cooldown_time
        current_state = STATE.PREPARE
    
    cooldown_time_temp -= 1

func minus_prepare_time() -> void:
    if not current_state == STATE.PREPARE:
        return
    
#    print("准备中，余剩：", prepare_time_temp)
    
    if prepare_time_temp <= 0:
        # 准备结束 | 开始生效
        prepare_time_temp = prepare_time
        current_state = STATE.RUNNING
        take_effect()
    
    prepare_time_temp -= 1

func get_data_from_values(_id:String) -> FlowerComputeData:
    for i in compute_values:
        if compute_values[i].id == _id:
            return compute_values[i]
    return null

func activate(_actor:Node, _compute_data:FlowerData, _output_data:FlowerData) -> void:
    actor = _actor
    origin_data = _compute_data
    output_data = _output_data
#    print("buff尝试激活，名称：", name)
    activated.emit()

func take_effect() -> void:
#    print("buff生效，名称：", name)
    # 拿一个属性：
#    var xxx = get_data_from_values("血量")
#    xxx.value = 1
    computed_values.emit()

func un_take_effect() -> void:
#    print("取消buff效果，名称：", name)
    # TODO: 考虑不要手动减去数值，但是有些buff在失效后也会执行一些操作
    computed_values.emit()

func remove() -> void:
#    print("buff效果结束，移除buff：", name)
    removed.emit()
