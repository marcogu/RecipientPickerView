//
//  ModalGroupController.m
//  ModalGroupContacts
//
//  Created by marco on 13-3-12.
//  Copyright (c) 2013年 marco. All rights reserved.
//

#import "ModalGroupController.h"
#import "SearchBar.h"

@interface ModalGroupController ()
@end

@implementation ModalGroupController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    _titlBar = [[[SearchBar alloc] init] autorelease];
    _titlBar.titleLabel.text = @"请选择联系人";
    [self.view addSubview:_titlBar];
}

@end
