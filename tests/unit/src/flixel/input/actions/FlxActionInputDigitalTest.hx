package flixel.input.actions;
import flixel.FlxState;
import flixel.input.FlxInput;
import flixel.input.IFlxInput;
import flixel.input.actions.FlxAction.FlxActionDigital;
import flixel.input.actions.FlxActionInputDigital.FlxActionInputDigitalMouseWheel;
import flixel.input.actions.FlxActionInputDigital.FlxActionInputDigitalGamepad;
import flixel.input.actions.FlxActionInputDigital.FlxActionInputDigitalIFlxInput;
import flixel.input.actions.FlxActionInputDigital.FlxActionInputDigitalKeyboard;
import flixel.input.actions.FlxActionInputDigital.FlxActionInputDigitalMouse;
import flixel.input.FlxInput;
import flixel.input.FlxInput.FlxInputState;
import flixel.input.actions.FlxActionInputDigital.FlxActionInputDigitalSteam;
import flixel.input.gamepad.FlxGamepad;
import flixel.input.gamepad.FlxGamepadInputID;
import flixel.input.keyboard.FlxKey;
import flixel.input.mouse.FlxMouseButton;
import flixel.input.mouse.FlxMouseButton.FlxMouseButtonID;
import flixel.util.FlxArrayUtil;
import flixel.util.FlxDestroyUtil.IFlxDestroyable;
import haxe.PosInfos;
import lime.ui.Gamepad;
import openfl.ui.GameInput;
import openfl.ui.GameInputDevice;

import flixel.util.typeLimit.OneOfFour;
import flixel.util.typeLimit.OneOfThree;
import flixel.util.typeLimit.OneOfTwo;


import massive.munit.Assert;

/**
 * ...
 * @author 
 */
class FlxActionInputDigitalTest extends FlxTest
{
	private var action:FlxActionDigital;
	
	private var value0:Int = 0;
	private var value1:Int = 0;
	private var value2:Int = 0;
	private var value3:Int = 0;
	
	@Before
	function before()
	{
		
	}
	
	@Test
	function testIFlxInput()
	{
		var t = new TestShell("iflxinput.");
		
		_testIFlxInput(t, false);
		
		//Press & release w/o callbacks
		t.assertTrue ("iflxinput.press1.just");
		t.assertTrue ("iflxinput.press1.value");
		t.assertFalse("iflxinput.press2.just");
		t.assertTrue ("iflxinput.press2.value");
		t.assertTrue ("iflxinput.release1.just");
		t.assertTrue ("iflxinput.release1.value");
		t.assertFalse("iflxinput.release2.just");
		t.assertTrue ("iflxinput.release2.value");
	}
	
	@Test
	function testIFlxInputCallbacks()
	{
		var t = new TestShell("iflxinput.");
		
		_testIFlxInput(t, true);
		
		//Press & release w/ callbacks
		t.assertTrue ("iflxinput.press1.callbacks.just");
		t.assertTrue ("iflxinput.press1.callbacks.value");
		t.assertFalse("iflxinput.press2.callbacks.just");
		t.assertTrue ("iflxinput.press2.callbacks.value");
		t.assertTrue ("iflxinput.release1.callbacks.just");
		t.assertTrue ("iflxinput.release1.callbacks.value");
		t.assertFalse("iflxinput.release2.callbacks.just");
		t.assertTrue ("iflxinput.release2.callbacks.value");
		
		//Callbacks themselves (1-4: pressed, just_pressed, released, just_released)
		for (i in 1...5)
		{
			t.assertTrue("iflxinput.press1.callbacks.callback"+i);
			t.assertTrue("iflxinput.press2.callbacks.callback"+i);
			t.assertTrue("iflxinput.release1.callbacks.callback"+i);
			t.assertTrue("iflxinput.release2.callbacks.callback"+i);
		}
	}
	
	function _testIFlxInput(test:TestShell, callbacks:Bool)
	{
		var state = new FlxInput<Int>(0);
		
		var a = new FlxActionInputDigitalIFlxInput(state, FlxInputState.PRESSED);
		var b = new FlxActionInputDigitalIFlxInput(state, FlxInputState.JUST_PRESSED);
		var c = new FlxActionInputDigitalIFlxInput(state, FlxInputState.RELEASED);
		var d = new FlxActionInputDigitalIFlxInput(state, FlxInputState.JUST_RELEASED);
		
		var clear = clearFlxInput.bind(state);
		var click = clickFlxInput.bind(state);
		
		testInputStates(test, clear, click, a, b, c, d, callbacks);
	}
	
	@Test
	function testFlxMouseButton()
	{
		var buttons = 
		[
			{name:"left", value:FlxMouseButtonID.LEFT}, 
			{name:"right", value:FlxMouseButtonID.RIGHT}, 
			{name:"middle", value:FlxMouseButtonID.MIDDLE}
		];
		
		for (button in buttons)
		{
			var name = button.name;
			var value = button.value;
			
			var t = new TestShell(name+".");
			_testFlxMouseButton(t, value, false);
			
			//Press & release w/o callbacks
			t.assertTrue (name+".press1.just");
			t.assertTrue (name+".press1.value");
			t.assertFalse(name+".press2.just");
			t.assertTrue (name+".press2.value");
			t.assertTrue (name+".release1.just");
			t.assertTrue (name+".release1.value");
			t.assertFalse(name+".release2.just");
			t.assertTrue (name+".release2.value");
		}
		
	}
	
	@Test
	function testFlxMouseButtonCallbacks()
	{
		var buttons = 
		[
			{name:"left", value:FlxMouseButtonID.LEFT},
			{name:"right", value:FlxMouseButtonID.RIGHT},
			{name:"middle", value:FlxMouseButtonID.MIDDLE}
		];
		
		for (button in buttons)
		{
			var name = button.name;
			var value = button.value;
			
			var t = new TestShell(name+".");
			_testFlxMouseButton(t, value, true);
			
			//Press & release w/ callbacks
			t.assertTrue (name+".press1.callbacks.just");
			t.assertTrue (name+".press1.callbacks.value");
			t.assertFalse(name+".press2.callbacks.just");
			t.assertTrue (name+".press2.callbacks.value");
			t.assertTrue (name+".release1.callbacks.just");
			t.assertTrue (name+".release1.callbacks.value");
			t.assertFalse(name+".release2.callbacks.just");
			t.assertTrue (name+".release2.callbacks.value");
			
			//Callbacks themselves (1-4: pressed, just_pressed, released, just_released)
			for (i in 1...5)
			{
				t.assertTrue(name+".press1.callbacks.callback"+i);
				t.assertTrue(name+".press2.callbacks.callback"+i);
				t.assertTrue(name+".release1.callbacks.callback"+i);
				t.assertTrue(name+".release2.callbacks.callback"+i);
			}
		}
	}
	
	function _testFlxMouseButton(test:TestShell, buttonID:FlxMouseButtonID, callbacks:Bool)
	{
		var button:FlxMouseButton = switch(buttonID)
		{
			case FlxMouseButtonID.LEFT: @:privateAccess FlxG.mouse._leftButton;
			case FlxMouseButtonID.RIGHT: @:privateAccess FlxG.mouse._rightButton;
			case FlxMouseButtonID.MIDDLE: @:privateAccess FlxG.mouse._middleButton;
			default: null;
		}
		
		var a = new FlxActionInputDigitalMouse(buttonID, FlxInputState.PRESSED);
		var b = new FlxActionInputDigitalMouse(buttonID, FlxInputState.JUST_PRESSED);
		var c = new FlxActionInputDigitalMouse(buttonID, FlxInputState.RELEASED);
		var d = new FlxActionInputDigitalMouse(buttonID, FlxInputState.JUST_RELEASED);
		
		var clear = clearMouseButton.bind(button);
		var click = clickMouseButton.bind(button);
		
		testInputStates(test, clear, click, a, b, c, d, callbacks);
	}
	
	private function getFlxKeys():Array<String>
	{
		//Trying to get these values directly from FlxG.keys.fromStringMap will cause the thing to hard crash whenever I try to do *ANY* logical test to exclude "ANY" from the returned array.
		//It's really creepy and weird!
		var arr = ["NUMPADSEVEN", "PERIOD", "ESCAPE", "A", "NUMPADEIGHT", "SIX", "B", "C", "D", "E", "ONE", "F", "LEFT", "G", "H", "ALT", "I", "J", "K", "CAPSLOCK", "L", "M", "N", "O", "P", "NUMPADTHREE", "SEMICOLON", "Q", "R", "S", "T", "NUMPADSIX", "U", "BACKSLASH", "V", "W", "X", "NUMPADONE", "Y", "Z", "UP", "QUOTE", "SLASH", "BACKSPACE", "HOME", "SHIFT", "DOWN", "F10", "F11", "FOUR", "SPACE", "F12", "ZERO", "PAGEUP", "F1", "DELETE", "F2", "TWO", "F3", "SEVEN", "F4", "F5", "EIGHT", "GRAVEACCENT", "F6", "NUMPADMULTIPLY", "F7", "PAGEDOWN", "F8", "FIVE", "NINE", "NUMPADFOUR", "F9", "TAB", "COMMA", "RBRACKET", "ENTER", "PRINTSCREEN", "INSERT", "END", "RIGHT", "LBRACKET", "CONTROL", "THREE", "NUMPADNINE", "NUMPADFIVE", "NUMPADTWO"];
		
		//these values will hard crash the test and I don't know why
		var problems = ["PLUS", "MINUS", "NUMPADPLUS", "NUMPADMINUS", "NUMPADPERIOD", "NUMPADZERO"];
		
		var arr2 = [];
		for (key in arr)
		{
			if (problems.indexOf(key) != -1)
			{
				arr2.push(key);
			}
		}
		
		return arr2;
	}
	
	@Test
	function testFlxKeyboard()
	{
		var keys = getFlxKeys();
		
		for (key in keys)
		{
			var t = new TestShell(key + ".");
			_testFlxKeyboard(t, key, false);
			
			//Press & release w/o callbacks
			t.assertTrue (key+".press1.just");
			t.assertTrue (key+".press1.value");
			t.assertFalse(key+".press2.just");
			t.assertTrue (key+".press2.value");
			t.assertTrue (key+".release1.just");
			t.assertTrue (key+".release1.value");
			t.assertFalse(key+".release2.just");
			t.assertTrue (key+".release2.value");
			
			//Test "ANY" key input as well:
			t.assertTrue (key+"any.press1.just");
			t.assertTrue (key+"any.press1.value");
			t.assertFalse(key+"any.press2.just");
			t.assertTrue (key+"any.press2.value");
			t.assertTrue (key+"any.release1.just");
			t.assertTrue (key+"any.release1.value");
			t.assertFalse(key+"any.release2.just");
			t.assertTrue (key+"any.release2.value");
		}
	}
	
	@Test
	function testFlxKeyboardCallbacks()
	{
		var keys = getFlxKeys();
		
		for (key in keys)
		{
			var t = new TestShell(key + ".");
			
			_testFlxKeyboard(t, key, true);
			
			//Press & release w/ callbacks
			t.assertTrue (key+".press1.callbacks.just");
			t.assertTrue (key+".press1.callbacks.value");
			t.assertFalse(key+".press2.callbacks.just");
			t.assertTrue (key+".press2.callbacks.value");
			t.assertTrue (key+".release1.callbacks.just");
			t.assertTrue (key+".release1.callbacks.value");
			t.assertFalse(key+".release2.callbacks.just");
			t.assertTrue (key+".release2.callbacks.value");
			
			//Test "ANY" key input as well:
			t.assertTrue (key+"any.press1.callbacks.just");
			t.assertTrue (key+"any.press1.callbacks.value");
			t.assertFalse(key+"any.press2.callbacks.just");
			t.assertTrue (key+"any.press2.callbacks.value");
			t.assertTrue (key+"any.release1.callbacks.just");
			t.assertTrue (key+"any.release1.callbacks.value");
			t.assertFalse(key+"any.release2.callbacks.just");
			t.assertTrue (key+"any.release2.callbacks.value");
			
			//Callbacks themselves (1-4: pressed, just_pressed, released, just_released)
			for (i in 1...5)
			{
				t.assertTrue(key+".press1.callbacks.callback"+i);
				t.assertTrue(key+".press2.callbacks.callback"+i);
				t.assertTrue(key+".release1.callbacks.callback"+i);
				t.assertTrue(key+".release2.callbacks.callback"+i);
				
				t.assertTrue(key+".any.press1.callbacks.callback"+i);
				t.assertTrue(key+".any.press2.callbacks.callback"+i);
				t.assertTrue(key+".any.release1.callbacks.callback"+i);
				t.assertTrue(key+".any.release2.callbacks.callback"+i);
			}
		}
	}
	
	function _testFlxKeyboard(test:TestShell, key:FlxKey, callbacks:Bool)
	{
		var a = new FlxActionInputDigitalKeyboard(key, FlxInputState.PRESSED);
		var b = new FlxActionInputDigitalKeyboard(key, FlxInputState.JUST_PRESSED);
		var c = new FlxActionInputDigitalKeyboard(key, FlxInputState.RELEASED);
		var d = new FlxActionInputDigitalKeyboard(key, FlxInputState.JUST_RELEASED);
		
		var aAny = new FlxActionInputDigitalKeyboard("ANY", FlxInputState.PRESSED);
		var bAny = new FlxActionInputDigitalKeyboard("ANY", FlxInputState.JUST_PRESSED);
		var cAny = new FlxActionInputDigitalKeyboard("ANY", FlxInputState.RELEASED);
		var dAny = new FlxActionInputDigitalKeyboard("ANY", FlxInputState.JUST_RELEASED);
		
		var clear = clearFlxKey.bind(key);
		var click = clickFlxKey.bind(key);
		
		testInputStates(test, clear, click, a, b, c, d, callbacks);
		test.name = test.name + ".any.";
		testInputStates(test, clear, click, a, b, c, d, callbacks);
	}
	
	@Test
	function testFlxMouseWheel()
	{
		var polarities =
		[
			{name:"positive", value:true},
			{name:"negative", value:false}
		];
		
		for (polarity in polarities)
		{
			var name = polarity.name;
			var value = polarity.value;
			
			var t = new TestShell(name+".");
			_testFlxMouseWheel(t, value, false);
			
			//Press & release w/o callbacks
			t.assertTrue (name+".press1.just");
			t.assertTrue (name+".press1.value");
			t.assertFalse(name+".press2.just");
			t.assertTrue (name+".press2.value");
			t.assertTrue (name+".release1.just");
			t.assertTrue (name+".release1.value");
			t.assertFalse(name+".release2.just");
			t.assertTrue (name+".release2.value");
		}
	}
	
	@Test
	function testFlxMouseWheelCallbacks()
	{
		var polarities = 
		[
			{name:"positive", value:true},
			{name:"negative", value:false}
		];
		
		for (polarity in polarities)
		{
			var name = polarity.name;
			var value = polarity.value;
			
			var t = new TestShell(name+".");
			_testFlxMouseWheel(t, value, true);
			
			//Press & release w/ callbacks
			t.assertTrue (name+".press1.callbacks.just");
			t.assertTrue (name+".press1.callbacks.value");
			t.assertFalse(name+".press2.callbacks.just");
			t.assertTrue (name+".press2.callbacks.value");
			t.assertTrue (name+".release1.callbacks.just");
			t.assertTrue (name+".release1.callbacks.value");
			t.assertFalse(name+".release2.callbacks.just");
			t.assertTrue (name+".release2.callbacks.value");
			
			//Callbacks themselves (1-4: pressed, just_pressed, released, just_released)
			for (i in 1...5)
			{
				t.assertTrue(name+".press1.callbacks.callback"+i);
				t.assertTrue(name+".press2.callbacks.callback"+i);
				t.assertTrue(name+".release1.callbacks.callback"+i);
				t.assertTrue(name+".release2.callbacks.callback"+i);
			}
		}
	}
	
	function _testFlxMouseWheel(test:TestShell, positive:Bool, callbacks:Bool)
	{
		var a = new FlxActionInputDigitalMouseWheel(positive, FlxInputState.PRESSED);
		var b = new FlxActionInputDigitalMouseWheel(positive, FlxInputState.JUST_PRESSED);
		var c = new FlxActionInputDigitalMouseWheel(positive, FlxInputState.RELEASED);
		var d = new FlxActionInputDigitalMouseWheel(positive, FlxInputState.JUST_RELEASED);
		
		var clear = clearFlxMouseWheel;
		var move = moveFlxMouseWheel.bind(positive);
		
		testInputStates(test, clear, move, a, b, c, d, callbacks);
	}
	
	function makeFakeGamepad():Dynamic
	{
		#if FLX_JOYSTICK_API
			//TODO:
		#elseif FLX_GAMEINPUT_API
			//TODO: 
		#end
		return null;
	}
	
	@Test
	function testFlxGamepad()
	{
		//TODO: make a fake gamepad somehow
		
		#if FLX_JOYSTICK_API
		
		#elseif FLX_GAMEINPUT_API
			
		#end
		
	}
	
	function _testFlxGamepad(test:TestShell, g:FlxGamepad, inputID:FlxGamepadInputID, callbacks:Bool)
	{
		/*
		var a = new FlxActionInputDigitalGamepad(inputID, FlxInputState.PRESSED);
		var b = new FlxActionInputDigitalGamepad(inputID, FlxInputState.JUST_PRESSED);
		var c = new FlxActionInputDigitalGamepad(inputID, FlxInputState.RELEASED);
		var d = new FlxActionInputDigitalGamepad(inputID, FlxInputState.JUST_RELEASED);
		
		var clear = clearFlxGamepad.bind(g, inputID);
		var click = clickFlxGamepad.bind(g, inputID);
		
		testInputStates(test, clear, click, a, b, c, d, callbacks);
		*/
	}
	
	@Test
	function testSteam()
	{
	
	}
	
	function _testSteam(test:TestShell, actionHandle:Int, callbacks:Bool)
	{
		/*
		var a = new FlxActionInputDigitalSteam(actionHandle, FlxInputState.PRESSED);
		var b = new FlxActionInputDigitalSteam(actionHandle, FlxInputState.JUST_PRESSED);
		var c = new FlxActionInputDigitalSteam(actionHandle, FlxInputState.RELEASED);
		var d = new FlxActionInputDigitalSteam(actionHandle, FlxInputState.JUST_RELEASED);
		
		var clear = clearSteam.bind(actionHandle);
		var click = clearSteam.bind(actionHandle);
		
		testInputStates(test, clear, click, a, b, c, d, callbacks);
		*/
	}
	
	/*********/
	
	function getCallback(i:Int){
		return function (a:FlxActionDigital){
			onCallback(i);
		}
	}
	
	function testInputStates(test:TestShell, clear:Void->Void, click:Bool->Array<FlxActionDigital>->Void, pressed:FlxActionInputDigital, jPressed:FlxActionInputDigital, released:FlxActionInputDigital, jReleased:FlxActionInputDigital, testCallbacks:Bool)
	{
		var aPressed:FlxActionDigital;
		var ajPressed:FlxActionDigital;
		var aReleased:FlxActionDigital;
		var ajReleased:FlxActionDigital;
		
		if (!testCallbacks)
		{
			ajPressed = new FlxActionDigital("jPressed", null);
			aPressed = new FlxActionDigital("pressed", null);
			ajReleased = new FlxActionDigital("jReleased", null);
			aReleased = new FlxActionDigital("released", null);
		}
		else
		{
			ajPressed = new FlxActionDigital("jPressed", getCallback(0));
			aPressed = new FlxActionDigital("pressed", getCallback(1));
			ajReleased = new FlxActionDigital("jReleased", getCallback(2));
			aReleased = new FlxActionDigital("released", getCallback(3));
		}
		
		ajPressed.addInput(jPressed);
		aPressed.addInput(pressed);
		ajReleased.addInput(jReleased);
		aReleased.addInput(released);
		
		var arr = [aPressed, ajPressed, aReleased, ajReleased];
		
		clear();
		
		var callbackStr = (testCallbacks ? "callbacks." : "");
		
		test.prefix = "press1." + callbackStr;
		
		//JUST PRESSED
		click(true, arr);
		test.testIsTrue(ajPressed.triggered, "just");
		test.testIsTrue(aPressed.triggered, "value");
		if (testCallbacks)
		{
			test.testIsTrue(value0 == 1, "callback1");
			test.testIsTrue(value1 == 1, "callback2");
			test.testIsTrue(value2 == 0, "callback3");
			test.testIsTrue(value3 == 0, "callback4");
		}
		
		test.prefix = "press2." + callbackStr;
		
		//STILL PRESSED
		click(true, arr);
		test.testIsFalse(ajPressed.triggered, "just");
		test.testIsTrue(aPressed.triggered, "value");
		if (testCallbacks)
		{
			test.testIsTrue(value0 == 1, "callback1");
			test.testIsTrue(value1 == 2, "callback2");
			test.testIsTrue(value2 == 0, "callback3");
			test.testIsTrue(value3 == 0, "callback4");
		}
		
		test.prefix = "release1." + callbackStr;
		
		//JUST RELEASED
		click(false, arr);
		test.testIsTrue(ajReleased.triggered, "just");
		test.testIsTrue(aReleased.triggered, "value");
		if (testCallbacks)
		{
			test.testIsTrue(value0 == 1, "callback1");
			test.testIsTrue(value1 == 2, "callback2");
			test.testIsTrue(value2 == 1, "callback3");
			test.testIsTrue(value3 == 1, "callback4");
		}
		
		test.prefix = "release2." + callbackStr;
		
		//STILL RELEASED
		click(false, arr);
		test.testIsFalse(ajReleased.triggered, "just");
		test.testIsTrue(aReleased.triggered, "value");
		if (testCallbacks)
		{
			test.testIsTrue(value0 == 1, "callback1");
			test.testIsTrue(value1 == 2, "callback2");
			test.testIsTrue(value2 == 1, "callback3");
			test.testIsTrue(value3 == 2, "callback4");
		}
		
		clear();
		clearValues();
		
		aPressed.destroy();
		aReleased.destroy();
		ajPressed.destroy();
		ajReleased.destroy();
	}
	
	@:access(flixel.input.gamepad.FlxGamepad)
	private function clearFlxGamepad(gamepad:FlxGamepad, ID:FlxGamepadInputID)
	{
		var input:FlxInput<Int> = gamepad.buttons[gamepad.mapping.getRawID(ID)];
		input.release();
		step();
		input.update();
		step();
		input.update();
	}
	
	@:access(flixel.input.mouse.FlxMouse)
	private function clearFlxMouseWheel()
	{
		if (FlxG.mouse == null) return;
		FlxG.mouse.wheel = 0;
		step();
		step();
	}
	
	@:access(flixel.input.FlxKeyManager)
	private function clearFlxKey(key:FlxKey)
	{
		var input:FlxInput<Int> = FlxG.keys._keyListMap.get(key);
		if (input == null) return;
		input.release();
		step();
		input.update();
		step();
		input.update();
	}
	
	private function clearMouseButton(button:FlxMouseButton)
	{
		if (button == null) return;
		button.release();
		step();
		button.update();
		step();
		button.update();
	}
	
	private function clearFlxInput(thing:FlxInput<Int>)
	{
		if (thing == null) return;
		thing.release();
		step();
		thing.update();
		step();
		thing.update();
	}
	
	@:access(flixel.input.gamepad.FlxGamepad)
	private function clickFlxGamepad(gamepad:FlxGamepad, ID:FlxGamepadInputID, pressed:Bool, arr:Array<FlxActionDigital>)
	{
		var input:FlxInput<Int> = gamepad.buttons[gamepad.mapping.getRawID(ID)];
		if (input == null) return;
		if (pressed) input.press();
		else input.release();
		updateActions(arr);
	}
	
	@:access(flixel.input.mouse.FlxMouse)
	private function moveFlxMouseWheel(positive:Bool, pressed:Bool, arr:Array<FlxActionDigital>)
	{
		if (FlxG.mouse == null) return;
		if (pressed)
		{
			if (positive)
			{
				FlxG.mouse.wheel = 1;
			}
			else
			{
				FlxG.mouse.wheel = -1;
			}
		}
		else
		{
			FlxG.mouse.wheel = 0;
		}
		updateActions(arr);
		step();
	}
	
	@:access(flixel.input.FlxKeyManager)
	private function clickFlxKey(key:FlxKey, pressed:Bool, arr:Array<FlxActionDigital>)
	{
		if (FlxG.keys == null || FlxG.keys._keyListMap == null) return;
		
		var input:FlxInput<Int> = FlxG.keys._keyListMap.get(key);
		if (input == null) return;
		
		step();
		
		input.update();
		
		if (pressed)
		{
			input.press();
		}
		else
		{
			input.release();
		}
		
		updateActions(arr);
		
	}
	
	private function clickMouseButton(button:FlxMouseButton, pressed:Bool, arr:Array<FlxActionDigital>)
	{
		if (button == null) return;
		step();
		button.update();
		if (pressed) button.press();
		else button.release();
		updateActions(arr);
	}
	
	private function clickFlxInput(thing:FlxInput<Int>, pressed:Bool, arr:Array<FlxActionDigital>)
	{
		if (thing == null) return;
		step();
		thing.update();
		if (pressed) thing.press();
		else thing.release();
		updateActions(arr);
	}
	
	private function updateActions(arr:Array<FlxActionDigital>)
	{
		for (a in arr)
		{
			if (a == null) continue;
			a.update();
		}
	}
	
	private function onCallback(i:Int)
	{
		switch(i){
			case 0: value0++;
			case 1: value1++;
			case 2: value2++;
			case 3: value3++;
		}
	}
	
	private function clearValues()
	{
		value0 = value1 = value2 = value3 = 0;
	}
}