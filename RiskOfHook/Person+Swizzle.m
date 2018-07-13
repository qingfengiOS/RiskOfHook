//
//  Person+Swizzle.m
//  HOOK
//
//  Created by 李一平 on 2018/7/11.
//  Copyright © 2018年 qingfengiOS. All rights reserved.
//

#import "Person+Swizzle.h"
#import <objc/runtime.h>

@implementation Person (Swizzle)

+ (void)load {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self qf_swizzleMethod:@selector(p_sayHello) withMethod:@selector(sayHello)];
    });
}

- (void)p_sayHello {
    [self p_sayHello];
    
    NSLog(@"Person + swizzle say hello");
}

+ (void)qf_swizzleMethod:(SEL)originSelector withMethod:(SEL)swizzleSelector {
    
    Class class = [self class];
    
    Method originMethod = class_getInstanceMethod(class, originSelector);
    Method swizzleMethod = class_getInstanceMethod(class, swizzleSelector);
    
    BOOL didAddMethod = class_addMethod(class, originSelector, method_getImplementation(swizzleMethod), method_getTypeEncoding(swizzleMethod));
    
    if (didAddMethod) {
        class_replaceMethod(class, swizzleSelector, method_getImplementation(originMethod), method_getTypeEncoding(originMethod));
    } else {
        method_exchangeImplementations(originMethod, swizzleMethod);
    }
}

@end
