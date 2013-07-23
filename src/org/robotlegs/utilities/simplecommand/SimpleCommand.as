//------------------------------------------------------------------------------
//  Copyright (c) 2012 the original author or authors. All Rights Reserved. 
// 
//  NOTICE: You are permitted you to use, modify, and distribute this file 
//  in accordance with the terms of the license agreement accompanying it. 
//------------------------------------------------------------------------------

package org.robotlegs.utilities.simplecommand
{
	import flash.events.EventDispatcher;
	
	import org.robotlegs.utilities.simplecommand.api.SimpleCommandEvent;
	import org.robotlegs.utilities.simplecommand.api.SimpleCommandFaultEvent;
	
	import robotlegs.bender.extensions.commandCenter.api.ICommand;


	public class SimpleCommand extends EventDispatcher implements ICommand
	{
		public var isComplete:Boolean = false; 

		public function execute():void
		{

		}

		public function commandComplete():void {
			if(!isComplete) {
				isComplete = true;
				dispatchEvent(new SimpleCommandEvent(SimpleCommandEvent.COMPLETE, this));
			} else {
				throw new Error("Command already completed");
			}
		}

		public function commandFault(faultMessage:String, faultCode:Number):void {
			dispatchEvent(new SimpleCommandFaultEvent(SimpleCommandFaultEvent.FAULT, this, faultMessage, faultCode));
		}
	}
}

