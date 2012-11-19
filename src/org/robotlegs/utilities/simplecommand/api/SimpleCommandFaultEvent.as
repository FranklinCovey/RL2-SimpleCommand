//------------------------------------------------------------------------------
//  Copyright (c) 2012 the original author or authors. All Rights Reserved. 
// 
//  NOTICE: You are permitted you to use, modify, and distribute this file 
//  in accordance with the terms of the license agreement accompanying it. 
//------------------------------------------------------------------------------

package org.robotlegs.utilities.simplecommand.api
{	
	import flash.events.Event;

	import org.robotlegs.utilities.simplecommand.SimpleCommand;

	public class SimpleCommandFaultEvent extends Event
	{
		public static const FAULT:String = "SimpleCommandEvent-FAULT";

		public var command:SimpleCommand;
		public var faultMessage:String;
		public var faultCode:Number;

		public function SimpleCommandFaultEvent(type:String, command:SimpleCommand, faultMessage:String, faultCode:Number)
		{
			super(type, false, false);
			this.command = command;
			this.faultMessage = faultMessage;
			this.faultCode = faultCode;
		}

		override public function clone():Event {
			return new SimpleCommandFaultEvent(type, command, faultMessage, faultCode);
		} 
	}
}

