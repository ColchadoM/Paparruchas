# This file is part of the videogame Paparruchas
# Copyright (C) 2021 medio inestable

# Paparruchas is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.

# Paparruchas is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.

# You should have received a copy of the GNU General Public License
# along with Paparruchas. If not, see <https://www.gnu.org/licenses/>.

# Any other information regarding this software please make sure to contact
# medioinestable@gmail.com


extends RigidBody2D




# Declare member variables here. Examples:

onready var colision = $CollisionShape2D
onready var sprite = $Sprite
var escala: Vector2


# Called when the node enters the scene tree for the first time.
func _ready():
	var r_escala = rand_range(0.5,1.4)
	escala = Vector2(r_escala, r_escala)
	colision.scale = escala
	sprite.scale = Vector2(escala.x + 0.43, escala.y + 0.43)
	


