class_name Actor
extends CharacterBody2D

var hp:int = 500:
    set(v):
        hp = v
        print("HP被修改：", hp)
var mp:int = 500:
    set(v):
        mp = v
        print("MP被修改：", mp)
var sp:int = 500:
    set(v):
        sp = v
        print("SP被修改：", sp)

func _ready() -> void:
    
    pass
