package flixel;

import flixel.FlxG;
import massive.munit.Assert;

@:access(flixel.FlxG)
class FlxGTest extends FlxTest
{
	@Test function testVERSIONNull():Void     { Assert.isNotNull(FlxG.VERSION); }
	@Test function testGameNull():Void        { Assert.isNotNull(FlxG.game); }
	@Test function testStageNull():Void       { Assert.isNotNull(FlxG.stage); }
	@Test function testStateNull():Void       { Assert.isNotNull(FlxG.state); }
	@Test function testWorldBoundsNull():Void { Assert.isNotNull(FlxG.worldBounds); }
	@Test function testSaveNull():Void        { Assert.isNotNull(FlxG.save); }
	
	/** Inputs **/
	
	#if !FLX_NO_MOUSE
	@Test function testMouseNull():Void       { Assert.isNotNull(FlxG.mouse); }
	#end
	#if !FLX_NO_TOUCH
	@Test function testTouchNull():Void       { Assert.isNotNull(FlxG.touches); }
	#end
	#if (!FLX_NO_MOUSE || !FLX_NO_TOUCH)
	@Test function testSwipesNull():Void      { Assert.isNotNull(FlxG.swipes); }
	#end
	#if !FLX_NO_KEYBOARD
	@Test function testKeysNull():Void        { Assert.isNotNull(FlxG.keys); }
	#end
	#if !FLX_NO_GAMEPAD
	@Test function testGamepadsNull():Void    { Assert.isNotNull(FlxG.gamepads); }
	#end
	#if android
	@Test function testAndroidNull():Void     { Assert.isNotNull(FlxG.android); }
	#end
	#if html5
	@Test function testHtml5Null():Void       { Assert.isNotNull(FlxG.html5); }
	#end
	
	/** frontends **/
	
	@Test function testInputsNull():Void      { Assert.isNotNull(FlxG.inputs); }
	@Test function testConsoleNull():Void     { Assert.isNotNull(FlxG.console); }
	@Test function testLogNull():Void         { Assert.isNotNull(FlxG.log); }
	@Test function testWatchNull():Void       { Assert.isNotNull(FlxG.watch); }
	@Test function testDebuggerNull():Void    { Assert.isNotNull(FlxG.debugger); }
	@Test function testVcrNull():Void         { Assert.isNotNull(FlxG.vcr); }
	@Test function testBitmapNull():Void      { Assert.isNotNull(FlxG.bitmap); }
	@Test function testCamerasNull():Void     { Assert.isNotNull(FlxG.cameras); }
	@Test function testPluginsNull():Void     { Assert.isNotNull(FlxG.plugins); }
	#if !FLX_NO_SOUND_SYSTEM
	@Test function testSoundNull():Void       { Assert.isNotNull(FlxG.sound); }
	#end
	
	@Test function testScaleModeNull():Void   { Assert.isNotNull(FlxG._scaleMode); }
	
	@Test
	function testDefaultWidth():Void
	{
		Assert.areEqual(640, FlxG.width);
	}
	
	@Test
	function testDefaultHeight():Void
	{
		Assert.areEqual(480, FlxG.height);
	}
}