extends Node2D

@onready var buff_manager:FlowerBuffManager = $PlayerBuffs

func _on_button_pressed() -> void:
    print("玩家伤害1：", buff_manager.output_data.damage)
    buff_manager.compute()
    await buff_manager.compute_ok
    print("玩家伤害2：", buff_manager.output_data.damage)

func _physics_process(_delta:float) -> void:
    $Label.text = "玩家伤害：%s" % str(buff_manager.output_data.damage)
