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

