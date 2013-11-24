package com.tjxjh.annotation;

import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

@Retention(RetentionPolicy.RUNTIME)
@Target(ElementType.METHOD)
public @interface AddClubPopularity
{
	public final static int MAX_COUNT = 5, MIN_COUNT = 0;
	/**
	 * 一次操作加多少知名度,默认1,范围:本类的MIN_COUNT~MAX_COUNT
	 */
	int weight() default 1;
}
