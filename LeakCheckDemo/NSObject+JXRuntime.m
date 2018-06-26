//
//  NSObject+JXRuntime.m
//  LeakCheckDemo
//
//  Created by 许伟杰 on 2018/6/26.
//  Copyright © 2018年 JackXu. All rights reserved.
//

#import "NSObject+JXRuntime.h"
#import<objc/runtime.h>

@implementation NSObject (JXRuntime)


+(void)swizzleSEL:(SEL)originalSEL withSEL:(SEL)swizzledSEL{
    
    Class class = [self class];
    Method originalMethod = class_getInstanceMethod(class, originalSEL);
    Method swizzledMethod = class_getInstanceMethod(class, swizzledSEL);
    
    BOOL didAddMethod = class_addMethod(class, originalSEL, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
    
    //若类没有实现需要被替换的原方法，也就是上一步添加原方法成功，此时已将本来要swizzle的方法的实现直接复制进原方法里。
    //还需要把新方法IMP指向原方法的实现：
    if (didAddMethod) {
        class_replaceMethod(class, swizzledSEL, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
    }
    //类有对应的原方法，则正常交换
    else{
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
    
    
    //参考：https://www.jianshu.com/p/1bacd182329f
    
}

- (void)willDealloc{
    
    __weak id weskself = self;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [weskself assertNotDealloc];
    });
    
}

- (void)assertNotDealloc{
    NSLog(@"Leaks %@",NSStringFromClass([self class]));
}

@end
