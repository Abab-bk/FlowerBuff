extends Node2D

@onready var buff_manager:FlowerBuffManager = $PlayerBuffs

func _on_button_pressed() -> void:
    var time1 = Time.get_ticks_msec()
    print("开始计算：", time1)
    buff_manager.compute()
    await buff_manager.compute_ok
    var time2 = Time.get_ticks_msec()
    print("计算结束：", time2)
    print("计算用时：", time2 - time1)
