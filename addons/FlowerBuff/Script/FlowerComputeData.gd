class_name FlowerComputeData
extends Resource

@export var id:StringName
@export var type:FlowerConst.COMPUTE_TYPE = FlowerConst.COMPUTE_TYPE.MORE
@export var value:float = 100.0
@export var formual:String
@export var target_property:String = ""

func _init(_id:String = "", _target_property:String = "", _type:int = 0, _value:float = 0.0) -> void:
    id = _id
    type = _type
    value = _value
    target_property = _target_property
