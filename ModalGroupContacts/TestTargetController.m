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
{
    SearchBar* _titlBar;
}
@end

@implementation TestTargetController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    _titlBar = [[[SearchBar alloc] init] autorelease];
    _titlBar.titleLabel.text = @"请选择联系人";
//    [self btnTest1];
    
    
    
    
    UIButton *facebookButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [facebookButton addTarget:self action:@selector(itemAction:) forControlEvents:UIControlEventTouchUpInside];
    [facebookButton setImage:[UIImage imageNamed:@"UIButtonBarSearch"] forState:UIControlStateNormal];
    facebookButton.frame = CGRectMake(0.0f, 0.0f, 30.0f, 30.0f);
    facebookButton.imageEdgeInsets = UIEdgeInsetsMake(3.0f, 3.0f, 3.0f, 3.0f);
    facebookButton.center = CGPointMake(15.0f, 15.0f);
    
    UIButton *twitterButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [twitterButton addTarget:self action:@selector(itemAction:) forControlEvents:UIControlEventTouchUpInside];
    [twitterButton setImage:[UIImage imageNamed:@"twitter"] forState:UIControlStateNormal];
    twitterButton.frame = CGRectMake(0.0f, 0.0f, 30.0f, 30.0f);
//    twitterButton.imageEdgeInsets = UIEdgeInsetsMake(13.0f, 13.0f, 13.0f, 13.0f);
    twitterButton.center = CGPointMake(55.0f, 15.0f);
    
    UIButton *mailButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [mailButton addTarget:self action:@selector(itemAction:) forControlEvents:UIControlEventTouchUpInside];
    [mailButton setImage:[UIImage imageNamed:@"mail"] forState:UIControlStateNormal];
    mailButton.frame = CGRectMake(0.0f, 0.0f, 30.0f, 30.0f);
//    mailButton.imageEdgeInsets = UIEdgeInsetsMake(13.0f, 13.0f, 13.0f, 13.0f);
    mailButton.center = CGPointMake(105.0f, 15.0f);
    
    _titlBar.items = [NSArray arrayWithObjects:facebookButton, twitterButton, mailButton, nil];
    
    [self.view addSubview:_titlBar];
}

-(void)btnTest1{
    UIImage* img = [UIImage imageNamed:@"UIButtonBarSearch"];
    NSLog(@"%@", img);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)itemAction:(id)sender {
    // Reset action picker
    [_titlBar close];
}

@end
