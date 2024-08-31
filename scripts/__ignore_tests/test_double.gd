extends GutTest

var MyScript = load('res://scripts/effects/base_effect.gd')
# Load the doubled object.
var doubled_script = double(MyScript).new()
## or
#var doubled_script = double(MyScript).new()
var MyScene = load('res://scenes/enemies/basic_enemy.tscn')
var DoubledScene = double(MyScene)
var doubled_scene = DoubledScene.instantiate()

# This is how assert_called behaves
func test_assert_called():
	var DOUBLE_ME_PATH = 'res://test/doubler_test_objects/double_extends_node2d.gd'

	var doubled =double(MyScript).new()  #double(DOUBLE_ME_PATH).new()
	doubled.start_effect( )
	#doubled.set_value(5)
	#doubled.has_two_params_one_default('a')
	#doubled.has_two_params_one_default('a', 'b')

	gut.p('-- passing --')
	assert_called(doubled, 'start_effect')
	#assert_called(doubled, 'set_value', [5])
	## note the passing of `null` here.  Default parameters must be supplied.
	#assert_called(doubled, 'has_two_params_one_default', ['a', null])
	#assert_called(doubled, 'has_two_params_one_default', ['a', 'b'])

	#gut.p('-- failing --')
	#assert_called(doubled, 'get_value')
	#assert_called(doubled, 'set_value', ['nope'])
	## This fails b/c Gut isn't smart enough to fill in default values for you...
	## ast least not yet.
	#assert_called(doubled, 'has_two_params_one_default', ['a'])
	## This fails with a specific message indicating that you have to pass an
	## instance of a doubled class.
	#assert_called(GDScript.new(), 'some_method')
