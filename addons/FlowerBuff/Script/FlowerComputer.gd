class_name FlowerComputer
extends Node

signal output_data_change

var origin_data:FlowerData # = {"Hp": 100}
var output_data:FlowerData
var more_data:Dictionary # = {"Sword": FlowerComputeData.new(FlowerConst.COMPUTE_TYPE.MORE, 100.0)}
var increase_data:Dictionary # = {"Sword": FlowerComputeData.new(FlowerConst.COMPUTE_TYPE.INCREASE, 500.0)}

func _ready() -> void:
    check_data()

func compute() -> void:
    compute_more()
    compute_increase()

func check_data() -> void:
    for i in more_data:
        if more_data[i].type == FlowerConst.COMPUTE_TYPE.MORE:
            continue
        assert(false, "Data != COMPUTE_TYPE.MORE")
    
    for i in increase_data:
        if increase_data[i].type == FlowerConst.COMPUTE_TYPE.INCREASE:
            continue
        assert(false, "Data != COMPUTE_TYPE.INCREASE")

func compute_more() -> void:
    output_data = origin_data.duplicate(true)
    var computed_data = output_data.duplicate(true)
    # BUG: 由于每次都 computed_data = origin_data.duplicate(true)，所以第二个修改的一样的数据会被覆盖为最新值
    for _modifier in more_data:
        # 如果没有这个属性
        if not origin_data.get(more_data[_modifier].target_property):
            continue
        # 计算
        var _origin_index:String = more_data[_modifier].target_property
        print("MORE计算前值：", computed_data[_origin_index])
        computed_data[_origin_index] = computed_data[_origin_index] + (computed_data[_origin_index] * more_data[_modifier].value)
        # 本次最终计算值：computed_data[_origin_index]，应该存到输出资源
        output_data[_origin_index] += computed_data[_origin_index] # 又算了一次，导致覆盖
        print("MORE计算后值：", output_data[_origin_index])
        output_data_change.emit()

func compute_increase() -> void:
    output_data = origin_data.duplicate(true)
    var computed_data = output_data.duplicate(true)
    
    for _modifier in increase_data:
        
        if not origin_data.get(increase_data[_modifier].target_property):
            continue
        
        var _origin_index:String = increase_data[_modifier].target_property
        print("INC计算前值：", computed_data[_origin_index])
        
        computed_data[_origin_index] = computed_data[_origin_index] + increase_data[_modifier].value
        
        output_data[_origin_index] += computed_data[_origin_index]
        print("INC计算后值：", output_data[_origin_index])
        
        output_data_change.emit()
