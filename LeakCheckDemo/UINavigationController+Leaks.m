//
//  UINavigationController+Leaks.m
//  LeakCheckDemo
//
//  Created by 许伟杰 on 2018/6/26.
//  Copyright © 2018年 JackXu. All rights reserved.
//

#import "UINavigationController+Leaks.h"
#import <objc/runtime.h>
#import "NSObject+JXRuntime.h"

@implementation UINavigationController (Leaks)

+ (void)load{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self swizzleSEL:@selector(popViewControllerAnimated:) withSEL:@selector(swizzled_popViewControllerAnimated:)];
    });
}

- (UIViewController*)swizzled_popViewControllerAnimated:(BOOL)animated{
    UIViewController *poppedViewController = [self swizzled_popViewControllerAnimated:animated];
    extern const void * const kHasBeenPoppedKey;
    //标记为已经出栈
    objc_setAssociatedObject(poppedViewController, kHasBeenPoppedKey, @(YES), OBJC_ASSOCIATION_RETAIN);
    return poppedViewController;
}

@end
