package com.tjxjh.annotation;

import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

import com.tjxjh.interceptor.AuthInterceptor.UserAuth;

@Retention(RetentionPolicy.RUNTIME)
@Target(ElementType.METHOD)
public @interface Auth
{
	Class<? extends UserAuth> type() default UserAuth.class;
}
