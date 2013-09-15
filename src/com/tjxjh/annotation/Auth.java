package com.tjxjh.annotation;

import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

import com.tjxjh.auth.AuthEnum;

/** auth数组间为'或'关系,默认值为空(0长度),仅当auth属性为空(即长度为0)时,type属性才生效(为了兼容性...) */
@Retention(RetentionPolicy.RUNTIME)
@Target(ElementType.METHOD)
public @interface Auth
{
	AuthEnum[] auths() default {};
	
	/** 如果前面那些注解全部都没有值(即为NO_NEED,默认值)才会用到这个方法 */
	@Deprecated
	Class<? extends com.tjxjh.interceptor.AuthInterceptor.BaseAuth> type() default com.tjxjh.interceptor.AuthInterceptor.UserAuth.class;
}
