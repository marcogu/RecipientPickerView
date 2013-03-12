//
//  TestTargetController.m
//  ModalGroupContacts
//
//  Created by marco on 13-3-10.
//  Copyright (c) 2013年 marco. All rights reserved.
//

#import "TestTargetController.h"
#import "ModalGroupController.h"
#import "SearchBar.h"

@interface TestTargetController ()
{
    UIButton* _btnGotoTarget;
}
@property(nonatomic, readonly)UIButton* btnGotoTarget;
@end

@implementation TestTargetController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self btnGotoTarget];
}

-(void)testTtitleBar{
    _titlBar = [[[SearchBar alloc] init] autorelease];
    _titlBar.titleLabel.text = @"请选择联系人";
    [self.view addSubview:_titlBar];
}

-(UIButton*)btnGotoTarget{
    if(!_btnGotoTarget){
        _btnGotoTarget = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        _btnGotoTarget.frame = CGRectMake(0, 0, 0, 0);
        [_btnGotoTarget setTitle:@"got to target" forState:UIControlStateNormal];
        [_btnGotoTarget addTarget:self action:@selector(gotoTargetHandler) forControlEvents:UIControlEventTouchUpInside];
        [_btnGotoTarget sizeToFit];
        [self.view addSubview:_btnGotoTarget];
    }
    return _btnGotoTarget;
}

-(void)gotoTargetHandler{
    ModalGroupController* _targetController = [[ModalGroupController alloc] initWithNibName:nil bundle:nil];
    [self.navigationController pushViewController:_targetController animated:YES];
}

@end
