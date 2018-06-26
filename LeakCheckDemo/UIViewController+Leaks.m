//
//  UIViewController+Leaks.m
//  LeakCheckDemo
//
//  Created by 许伟杰 on 2018/6/26.
//  Copyright © 2018年 JackXu. All rights reserved.
//

#import "UIViewController+Leaks.h"
#import "NSObject+JXRuntime.h"
#import <objc/runtime.h>

const void *const kHasBeenPoppedKey = "kHasBeenPoppedKey";//标记是否已经出栈

@implementation UIViewController (Leaks)

+ (void)load{
//    对于C语言，编译时便决定了函数的调用顺序，而对于OC语言，属于动态调用过程，函数调用是通过消息发送机制，在真正运行时才会根据函数名去查找对应的函数进行调用。
    
    //正常情况load只会执行一次，使用dispatch_once是为了防止人为调用load方法
    //在load方法而不是在initalize方法中进行交换的原因：（1）load在类被加载时调用，initalize在类或其子类收到第一条消息时才被调用，类似懒加载。（2）load方法在父类、子类、分类中是独立的
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self swizzleSEL:@selector(viewWillAppear:) withSEL:@selector(swizzled_viewWillAppear:)];
        [self swizzleSEL:@selector(viewDidDisappear:) withSEL:@selector(swizzled_viewDidDisappear:)];
    });
}


- (void) swizzled_viewWillAppear:(BOOL) animated{
    [self swizzled_viewWillAppear:animated];
    
    //标记为进栈
    objc_setAssociatedObject(self, kHasBeenPoppedKey, @(NO), OBJC_ASSOCIATION_RETAIN);
}

-(void) swizzled_viewDidDisappear:(BOOL) animated{
    [self swizzled_viewDidDisappear:animated];
    
    //已经出栈
    if ([objc_getAssociatedObject(self, kHasBeenPoppedKey) boolValue] == YES) {
        //判断对象是否被销毁
        [self willDealloc];
    }
}

@end
