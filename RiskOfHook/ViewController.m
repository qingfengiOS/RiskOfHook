//
//  ViewController.m
//  HOOK
//
//  Created by 李一平 on 2018/7/11.
//  Copyright © 2018年 qingfengiOS. All rights reserved.
//

#import "ViewController.h"
#import "Person.h"
#import "Student.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    Student *s = [Student new];
    [s sayHello];
    
    /*
    结果：
     2018-07-11 15:31:06.140914+0800 HOOK[37296:847902] peron say hello
     2018-07-11 15:31:06.141019+0800 HOOK[37296:847902] Student + swizzle say hello
     
     为什么没有调到person的“Person + swizzle say hello”？
     
     因为：我们都知道在 Objective-C 的世界里父类的 +load 早于子类，但是并没有限制父类的分类加载会早于子类的分类的加载，实际上这取决于编译的顺序。最终会按照编译的顺序合并进 Mach-O 的固定 section 内。
    */
}

@end
