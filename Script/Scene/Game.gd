extends Node2D

@onready var buff_manager:FlowerBuffManager = $PlayerBuffs

func _ready() -> void:
    buff_manager.compute()
