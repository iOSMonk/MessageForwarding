//
//  RuntimeClass.m
//  MessageForwarding
//
//  Created by tiange on 2019/8/14.
//  Copyright © 2019 tiange. All rights reserved.
//

#import "RuntimeClass.h"
#import <objc/runtime.h>

@implementation RuntimeClass


+ (void)testIMP
{
    NSLog(@"---veryitman--- +proxyMethod of class's method for OC.");
}


+ (BOOL)resolveClassMethod:(SEL)sel
{
    if (sel == @selector(test1)) {
        //         class_addMethod([self class], @selector(test1), testIMP, "v@:");
        NSLog(@"resolveClassMethod:");
        
        
        // 获取 MetaClass
        Class predicateMetaClass = objc_getMetaClass([NSStringFromClass(self) UTF8String]);
        // 根据 metaClass 获取方法的实现
        IMP impletor = class_getMethodImplementation(predicateMetaClass, @selector(testIMP));
        // 获取类方法
        Method predicateMethod = class_getClassMethod(predicateMetaClass, @selector(testIMP));
        const char *encoding = method_getTypeEncoding(predicateMethod);
        
        // 动态添加类方法
        class_addMethod(predicateMetaClass, sel, impletor, encoding);
        
        return YES;
    }
    return [super resolveClassMethod:sel];
}


+ (id)forwardingTargetForSelector:(SEL)aSelector{
    
    if (aSelector == @selector(test1)) {
        NSLog(@"forwardingTargetForSelector:");
        return nil;
    }
    
    return [super forwardingTargetForSelector:aSelector];
}


+ (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector{
    
    if (aSelector == @selector(test1)) {
        NSLog(@"methodSignatureForSelector:");
        return [NSMethodSignature signatureWithObjCTypes:"v@:"];
    }
    
    return [super methodSignatureForSelector:aSelector];
}

+ (void)forwardInvocation:(NSInvocation *)anInvocation
{
    NSLog(@"forwardInvocation:");
}


@end
