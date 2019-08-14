//
//  RuntimeObject.m
//  MessageForwarding
//
//  Created by tiange on 2019/8/14.
//  Copyright © 2019 tiange. All rights reserved.
//

#import "RuntimeObject.h"
#import <objc/runtime.h>

@implementation RuntimeObject


- (void)testIMP
{
    NSLog(@"---veryitman--- +proxyMethod of class's method for OC.");
}
//动态地为实例方法的给定选择器提供实现。
+ (BOOL)resolveInstanceMethod:(SEL)sel
{
    if (sel == @selector(test)) {
        
        NSLog(@"resolveInstanceMethod:");
        IMP impletor = class_getMethodImplementation(self, @selector(testIMP));
        // 获取类方法
        Method predicateMethod = class_getClassMethod(self, @selector(testIMP));
        const char *encoding = method_getTypeEncoding(predicateMethod);
        
        class_addMethod(self,  @selector(test), impletor, encoding);
        return NO;
    }
    
    return [super resolveInstanceMethod:sel];
}
//返回首先应将无法识别的消息定向到的对象。
- (id)forwardingTargetForSelector:(SEL)aSelector{
    if (aSelector == @selector(test)) {
        NSLog(@"forwardingTargetForSelector:");
        return nil;
    }
    
    return [super forwardingTargetForSelector:aSelector];
}

//返回一个NSMethodSignature对象，该对象包含给定选择器标识的方法的描述。
- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector{
    
    if (aSelector == @selector(test)) {
        NSLog(@"methodSignatureForSelector:");
        return [NSMethodSignature signatureWithObjCTypes:"v@:"];
    }
    
    return [super methodSignatureForSelector:aSelector];
}
//由子类重写以将消息转发到其他对象
- (void)forwardInvocation:(NSInvocation *)anInvocation
{
    NSLog(@"forwardInvocation:");
}


@end
