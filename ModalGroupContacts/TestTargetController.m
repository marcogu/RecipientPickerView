//
//  TestTargetController.m
//  ModalGroupContacts
//
//  Created by marco on 13-3-10.
//  Copyright (c) 2013年 marco. All rights reserved.
//

#import "TestTargetController.h"
#import "SearchBar.h"

@interface TestTargetController ()
@end

@implementation TestTargetController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    _titlBar = [[[SearchBar alloc] init] autorelease];
    _titlBar.titleLabel.text = @"请选择联系人";
    [self.view addSubview:_titlBar];
}

@end
