package org.josht.starling.foxhole.kitchenSink.screens
{
	import org.josht.starling.display.Screen;
	import org.josht.starling.foxhole.controls.Button;
	import org.josht.starling.foxhole.controls.ScreenHeader;
	import org.osflash.signals.ISignal;
	import org.osflash.signals.Signal;

	public class MainMenuScreen extends Screen
	{
		private static const LABELS:Vector.<String> = new <String>
		[
			"Button",
			"Slider",
			"Toggle Switch",
			"List",
			"Picker List"
		];
		
		public function MainMenuScreen()
		{
			super();
		}
		
		private var _onButton:Signal = new Signal(MainMenuScreen);
		
		public function get onButton():ISignal
		{
			return this._onButton;
		}
		
		private var _onSlider:Signal = new Signal(MainMenuScreen);
		
		public function get onSlider():ISignal
		{
			return this._onSlider;
		}
		
		private var _onToggleSwitch:Signal = new Signal(MainMenuScreen);
		
		public function get onToggleSwitch():ISignal
		{
			return this._onToggleSwitch;
		}
		
		private var _onList:Signal = new Signal(MainMenuScreen);
		
		public function get onList():ISignal
		{
			return this._onList;
		}
		
		private var _onPickerList:Signal = new Signal(MainMenuScreen);
		
		public function get onPickerList():ISignal
		{
			return this._onPickerList;
		}
		
		private var _header:ScreenHeader;
		private var _buttons:Vector.<Button> = new <Button>[];
		
		override protected function initialize():void
		{
			const signals:Vector.<Signal> = new <Signal>[this._onButton, this._onSlider, this._onToggleSwitch, this._onList, this._onPickerList];
			const buttonCount:int = LABELS.length;
			for(var i:int = 0; i < buttonCount; i++)
			{
				var label:String = LABELS[i];
				var signal:Signal = signals[i];
				var button:Button = new Button();
				button.label = label;
				this.triggerSignalOnButtonRelease(button, signal);
				this.addChild(button);
				this._buttons.push(button);
			}

			this._header = new ScreenHeader();
			this._header.title = "Foxhole for Starling";
			this.addChild(this._header);
		}
		
		override protected function layout():void
		{
			const spacingY:Number = this.originalHeight * 0.02 * this.dpiScale;

			this._header.width = this.stage.stageWidth;
			this._header.validate();
			
			var positionY:Number = this._header.y + this._header.height + spacingY;
			const buttonCount:int = this._buttons.length;
			for(var i:int = 0; i < buttonCount; i++)
			{
				var button:Button = this._buttons[i];
				button.width = 440 * this.dpiScale;
				button.height = 88 * this.dpiScale;
				button.x = (this.stage.stageWidth - button.width) / 2;
				button.y = positionY;
				positionY += button.height + spacingY;
			}
		}
		
		private function triggerSignalOnButtonRelease(button:Button, signal:Signal):void
		{
			const self:MainMenuScreen = this;
			button.onRelease.add(function(button:Button):void
			{
				signal.dispatch(self);
			});
		}
	}
}