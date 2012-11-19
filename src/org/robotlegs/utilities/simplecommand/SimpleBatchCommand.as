//------------------------------------------------------------------------------
//  Copyright (c) 2012 the original author or authors. All Rights Reserved. 
// 
//  NOTICE: You are permitted you to use, modify, and distribute this file 
//  in accordance with the terms of the license agreement accompanying it. 
//------------------------------------------------------------------------------

package org.robotlegs.utilities.simplecommand
{
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;

	import org.robotlegs.utilities.simplecommand.api.SimpleCommandEvent;
	import org.robotlegs.utilities.simplecommand.api.SimpleCommandFaultEvent;
	import org.swiftsuspenders.Injector;

	import robotlegs.bender.extensions.commandCenter.api.ICommand;

	public class SimpleBatchCommand extends SimpleCommand implements ICommand
	{
		private var _commandsToRun:Vector.<Class> = new Vector.<Class>();
		private var _currentIndex:uint;
		private var _completeCount:uint;
		private var _executing:Boolean = false;
		private var _injector:Injector;

		public var sequenceMode:Boolean = false;

		[Inject]
		public var injector:Injector;


		/**
		 * Add a command to this batch.
		 */
		public function addCommand(command:Class):void {
			_commandsToRun.push(command);
		}

		/**
		 * This will execute all the commands in parrallel
		 */
		override public function execute():void
		{
			_executing = true;
			_completeCount = 0;
			_currentIndex = 0;

			var className:String = getQualifiedClassName(this);
			var batchCommandClass:Class = getDefinitionByName(className) as Class;

			_injector ||= injector.createChildInjector();
			_injector.map(SimpleBatchCommand).toValue(this);
			_injector.map(batchCommandClass).toValue(this);


			if(sequenceMode && _commandsToRun.length > 0) {
				runCommand(0);
			} else {
				for(var i:uint=0; i<_commandsToRun.length; i++) {
					runCommand(i);
				}
			}
		}

		private function runCommand(index:uint):void {
			var commandInstanceRaw:* = new _commandsToRun[index];
			if(!commandInstanceRaw is SimpleCommand)
				throw new Error("SimpleBatchCommand can only run SimpleCommands!");

			var command:SimpleCommand = commandInstanceRaw as SimpleCommand;
			addEventHandlersToCommand(command);
			_injector.injectInto(command);
			command.execute();
		}

		private function addEventHandlersToCommand(command:SimpleCommand):void {
			command.addEventListener(SimpleCommandEvent.COMPLETE, handleCommandComplete);
			command.addEventListener(SimpleCommandFaultEvent.FAULT, handleCommandFault);
		}

		private function removeEventHandlersToCommand(command:SimpleCommand):void {
			command.removeEventListener(SimpleCommandEvent.COMPLETE, handleCommandComplete);
			command.removeEventListener(SimpleCommandFaultEvent.FAULT, handleCommandFault);
		}

		private function handleCommandComplete(event:SimpleCommandEvent):void {
			_completeCount++;

			if(_completeCount == _commandsToRun.length) {
				_executing = false;
				commandComplete();
			} else if(sequenceMode) {
				_currentIndex++;
				runCommand(_currentIndex);
			}
		}

		private function handleCommandFault(event:SimpleCommandFaultEvent):void {
			dispatchEvent(event);
		}
	}
}

