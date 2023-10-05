class_name SimpleBuff
extends FlowerBaseBuff

enum PROPERTY {HP, MP, SP}
enum WAY {PLUS, DEVIDE}

@export var value:int
@export var way:WAY
@export var property:PROPERTY

func take_effect() -> void:
    match property:
        PROPERTY.HP:
            match way:
                WAY.PLUS:
                    actor.hp += value
                WAY.DEVIDE:
                    actor.hp /= value
        PROPERTY.MP:
            match way:
                WAY.PLUS:
                    actor.mp += value
                WAY.DEVIDE:
                    actor.mp /= value
        PROPERTY.SP:
            match way:
                WAY.PLUS:
                    actor.sp += value
                WAY.DEVIDE:
                    actor.sp /= value

func un_take_effect() -> void:
    match property:
        PROPERTY.HP:
            match way:
                WAY.PLUS:
                    actor.hp -= value
                WAY.DEVIDE:
                    actor.hp *= value
        PROPERTY.MP:
            match way:
                WAY.PLUS:
                    actor.mp -= value
                WAY.DEVIDE:
                    actor.mp *= value
        PROPERTY.SP:
            match way:
                WAY.PLUS:
                    actor.sp -= value
                WAY.DEVIDE:
                    actor.sp *= value
    
