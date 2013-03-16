//
//  ModalGroupController.m
//  ModalGroupContacts
//
//  Created by marco on 13-3-12.
//  Copyright (c) 2013年 marco. All rights reserved.
//

#import "ModalGroupController.h"
#import "ICMenuTableDatasource.h"
#import "SelectorTableViewDelegate.h"
#import "SearchBar.h"

@interface ModalGroupController ()
@property(nonatomic, retain)ICMenuTableDatasource* tableViewDataSource;
@end

@implementation ModalGroupController

- (void)viewDidLoad{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
    self.tableViewDataSource = [ICMenuTableDatasource createDemoSections:self.tableView];
    SelectorTableViewDelegate* tbdelegate = [[SelectorTableViewDelegate alloc] initWithAboveViewOnTable:nil belowViewOnTable:nil];
    tbdelegate.ds = _tableViewDataSource;
    self.tableView.dataSource = self.tableViewDataSource;
    self.tableView.delegate = tbdelegate;
    self.titlBar.titleLabel.text = @"请选择联系人";
}

-(SearchBar*)titlBar{
    if (!_titlBar) {
        _titlBar = [[SearchBar alloc] init];
        [self.view addSubview:_titlBar];
        [_titlBar release];
    }
    return _titlBar;
}

-(UITableView*)tableView{
    if (!_tableView) {
        float tableHeight = self.view.frame.size.height-45;
        CGRect tableFrame = {{0, 45},{self.view.frame.size.width,tableHeight}};
        _tableView = [[UITableView alloc] initWithFrame:tableFrame style:UITableViewStylePlain];
        _tableView.allowsMultipleSelection = YES;
//        _tableView.separatorColor = [UIColor redColor];
        _tableView.accessibilityLabel = @"reciverTabel";
        [self.view addSubview:_tableView];
        [_tableView release];
    }
    return _tableView;
}

@end
