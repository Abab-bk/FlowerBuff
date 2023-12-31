class_name FlowerComputer
extends Node

signal output_data_change
#signal computer_ok

var origin_data:FlowerData
var output_data:FlowerData
var all_data:Array

var buff_manager:FlowerBuffManager

func compute() -> void:
    compute_all()

func compute_all() -> void:
    output_data = origin_data.duplicate(true)
    
    var computed_data = origin_data.duplicate(true)
    
    var _count:int = 0
    
    for __modifier in all_data:
#        var __modifier:FlowerComputeData = all_data[_modifier]
        # 如果没有这个属性
        if not origin_data.get(__modifier.target_property):
            continue
        
        _count += 1
        print("匹配__modifier第 %s 次" % str(_count))
        
        # FIXME: 由于origin_data不对，导致computed_data不对，再导致计算错误
        
        match __modifier.type:
            # 根据modifier的type计算
            FlowerConst.COMPUTE_TYPE.MORE:
                
#                var computed_data = origin_data.duplicate(true)
                
                var _target_property:String = __modifier.target_property
                computed_data[_target_property] = \
                computed_data[_target_property] + (computed_data[_target_property] * __modifier.value)
                # 本次最终计算值：computed_data[_origin_index]，应该存到输出资源
                output_data[_target_property] = computed_data[_target_property] # 又算了一次，导致覆盖
#                output_data_change.emit()
                
            FlowerConst.COMPUTE_TYPE.INCREASE:
                
#                var computed_data = origin_data.duplicate(true)
                
                var _target_property:String = __modifier.target_property
                computed_data[_target_property] = computed_data[_target_property] + __modifier.value
                output_data[_target_property] = computed_data[_target_property]
#                output_data_change.emit()
                
            FlowerConst.COMPUTE_TYPE.COMPLEX_INCREASE:
#                var computed_data = origin_data.duplicate(true)
                
                var _origin_index:String = __modifier.target_property

                # 首先拿到公式
#                var formual:String = __modifier.formual
                var formual:String = analyse_formula(__modifier.formual)
                
                var exp:Expression = Expression.new()
                exp.parse(formual)
                var result = exp.execute()
                
                computed_data[_origin_index] = result
                output_data[_origin_index] += computed_data[_origin_index]
                
#                output_data_change.emit()
            
            FlowerConst.COMPUTE_TYPE.COMPLEX_MORE:
#                var computed_data = origin_data.duplicate(true)
                
                var _origin_index:String = __modifier.target_property
                
                # 首先拿到公式
                var formual:String = analyse_formula(__modifier.formual)
                
                var exp:Expression = Expression.new()
                exp.parse(formual)
                var result = exp.execute()
                
                computed_data[_origin_index] = result
                output_data[_origin_index] += output_data[_origin_index] * computed_data[_origin_index]
                
#                output_data_change.emit()
    
    output_data_change.emit()
    
    buff_manager.compute_ok.emit()

func analyse_formula(_formula:String) -> String:
    # 首先通过正则解析方括号内内容：
    var reg:RegEx = RegEx.new()
    reg.compile("(?<=\\[)(.+?)(?=\\])")
    var _search_result:Array[RegExMatch] = reg.search_all(_formula)
    
    for _item in _search_result:
        for _target_property in _item.strings:
            # 判断 origin_data 中是否有该属性
            if not origin_data.get(_target_property):
                assert(false, "Can't find the value in formula: %s in compute_data, check plz." % _target_property)
                continue
            
            _formula = _formula.replace("[%s]" % str(_target_property), str(origin_data[_target_property]))
    
    return _formula

