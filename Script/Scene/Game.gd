extends Node2D

@onready var buff_manager:FlowerBuffManager = $FlowerBuffManager

func _ready() -> void:
    buff_manager.compute()
