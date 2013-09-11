package com.tjxjh.annotation;

import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

import com.tjxjh.auth.AdminAuthEnum;
import com.tjxjh.auth.MerchantAuthEnum;
import com.tjxjh.auth.UserAuthEnum;
import com.tjxjh.interceptor.AuthInterceptor;

/** 里面的三个注解属性为或关系,默认值都为NO_NEED(不检查),仅当三个都为NO_NEED时,type属性才生效(为了兼容性...) */
@Retention(RetentionPolicy.RUNTIME)
@Target(ElementType.METHOD)
public @interface Auth {
	UserAuthEnum user() default UserAuthEnum.LOGIN;

	MerchantAuthEnum merchant() default MerchantAuthEnum.NO_NEED;

	AdminAuthEnum admin() default AdminAuthEnum.NO_NEED;

	/** 如果前面那些注解全部都没有值(即为NO_NEED,默认值)才会用到这个方法 */
	@Deprecated
	Class<? extends com.tjxjh.interceptor.AuthInterceptor.BaseAuth> type() default com.tjxjh.interceptor.AuthInterceptor.BaseAuth.class;
}
