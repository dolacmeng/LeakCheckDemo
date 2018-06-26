//
//  NSObject+JXRuntime.h
//  LeakCheckDemo
//
//  Created by 许伟杰 on 2018/6/26.
//  Copyright © 2018年 JackXu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (JXRuntime)

+(void)swizzleSEL:(SEL)originalSEL withSEL:(SEL)swizzledSEL;
-(void)willDealloc;

@end
