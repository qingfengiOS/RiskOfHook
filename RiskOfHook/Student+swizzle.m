//
//  Student+swizzle.m
//  HOOK
//
//  Created by 李一平 on 2018/7/11.
//  Copyright © 2018年 qingfengiOS. All rights reserved.
//

#import "Student+swizzle.h"
#import <objc/runtime.h>

@implementation Student (swizzle)

+ (void)load {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        Class class = [self class];
        
        SEL originSelector = @selector(sayHello);
        SEL swizzledSelector = @selector(s_sayHello);
        
        Method originMethod = class_getInstanceMethod(class, originSelector);
        Method swizzedMethod = class_getInstanceMethod(class, swizzledSelector);
        
        BOOL didAddMethod = class_addMethod(class, originSelector, method_getImplementation(swizzedMethod), method_getTypeEncoding(swizzedMethod));
        if (didAddMethod) {
            class_replaceMethod(class, swizzledSelector, method_getImplementation(originMethod), method_getTypeEncoding(originMethod));
        } else {
            method_exchangeImplementations(originMethod, swizzedMethod);
        }
        
    });
    
}

- (void)s_sayHello {
    [self s_sayHello];
    
    NSLog(@"Student + swizzle say hello");
}



@end
