//
//  ViewController.m
//  MessageForwarding
//
//  Created by tiange on 2019/8/14.
//  Copyright © 2019 tiange. All rights reserved.
//

#import "ViewController.h"
#import "RuntimeObject.h"
#import "RuntimeClass.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    RuntimeObject *obj = [[RuntimeObject alloc]init];
    [obj test];
    
    [RuntimeClass test1];
}


@end
