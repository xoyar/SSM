package com.xoyar.cms.annotation;

import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

/**
 * @interface代表自定义注解
 * @Target代表注解的作用域,方法级别
 * @Retention:生命周期，runtime：运行时存在source：源代码显示class：编译到class
 */
@Target(ElementType.METHOD)
@Retention(RetentionPolicy.RUNTIME)
public @interface Permission {

    String value();

}
