package org.robotlegs.utilities.simplecommand.api
{
	import flash.events.Event;

	import org.robotlegs.utilities.simplecommand.SimpleCommand;

	public class SimpleCommandEvent extends Event
	{
		public static const STARTED:String = "SimpleCommandEvent-COMMAND_STARTED";
		public static const COMPLETE:String = "SimpleCommandEvent-COMMAND_COMPLETE";

		public var command:SimpleCommand;

		public function SimpleCommandEvent(type:String, command:SimpleCommand)
		{
			super(type, false, false);
			this.command = command;
		}

		override public function clone():Event {
			return new SimpleCommandEvent(type, command);
		}
	}
}

