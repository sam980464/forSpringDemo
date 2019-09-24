package com.util;

import ch.qos.logback.classic.pattern.ClassicConverter;
import ch.qos.logback.classic.spi.ILoggingEvent;

public class ThreadIdPatternConverter extends ClassicConverter {

	@Override
	public String convert(ILoggingEvent event) {
		return Long.toString(Thread.currentThread().getId());
	}

}
