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
#import "ICRecipientPicker.h"
#import "SearchBar.h"

@interface ModalGroupController ()<ICRecipientPickerDataSource>{
    ICRecipientPicker* _picker;
}
@property(nonatomic, retain)ICMenuTableDatasource* tableViewDataSource;
@property(nonatomic, readonly)ICRecipientPicker* picker;
@end

@implementation ModalGroupController

- (void)viewDidLoad{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
    self.tableViewDataSource = [ICMenuTableDatasource createDemoSections:self.tableView];
    self.tableView.dataSource = self.tableViewDataSource;
    SelectorTableViewDelegate* tbdelegate = [[SelectorTableViewDelegate alloc] initWithAboveViewOnTable:self.picker belowViewOnTable:nil];
    tbdelegate.ds = _tableViewDataSource;
    self.tableView.delegate = tbdelegate;
    self.picker.datasource = self;
    
    self.titlBar.titleLabel.text = @"请选择联系人";
    
    self.tableView.contentInset = UIEdgeInsetsMake(45, 0, 0, 0);
}

// use test
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
//    self.tableView.contentOffset = CGPointMake(0, -44);
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
        _tableView.accessibilityLabel = @"reciverTabel";
        [self.view addSubview:_tableView];
        [_tableView release];
    }
    return _tableView;
}

-(ICRecipientPicker*)picker{
    if (!_picker) {
        _picker = [[ICRecipientPicker alloc] initWithFrame:CGRectMake(0, 45, self.view.frame.size.width, 44)];
        _picker.selectionStyle = ICRecipientPickerSelectionStyleDefault;
        _picker.backgroundColor = [UIColor underPageBackgroundColor]; // test model.
        [self.view addSubview:_picker];
        [_picker release];
    }
    return _picker;
}

#pragma mark - ICRecipientPickerDataSource

-(ICRecipientPickerItem *)recipientPicker:(ICRecipientPicker*)pickerView itemForIndex:(NSInteger)index{
    // test logic.
    ICRecipientPickerItem* item = [[ICRecipientPickerItem alloc] init];
    item.textLabel.text = @"黄胜东";
    return item;
}

@end
