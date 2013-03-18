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
#import "ReciverVo.h"

@interface ModalGroupController ()<ICRecipientPickerDataSource>{
    ICRecipientPicker* _picker;
}
@property(nonatomic, retain)ICMenuTableDatasource* tableViewDataSource;
@property(nonatomic, readonly)ICRecipientPicker* picker;
@end

#define DEFAULT_PICKER_TOP 0
#define DEFAULT_PICKER_HEIGHT 44
#define DEFAULT_TABLE_TOP 45

@implementation ModalGroupController

- (void)viewDidLoad{
    [super viewDidLoad];
    
    self.tableViewDataSource = [ICMenuTableDatasource createDemoSections:_tableView];
    self.tableView.dataSource = self.tableViewDataSource;
    SelectorTableViewDelegate* tbdelegate = [[SelectorTableViewDelegate alloc] initWithAboveViewOnTable:_picker belowViewOnTable:nil];
    tbdelegate.ds = _tableViewDataSource;
    self.tableView.delegate = tbdelegate;
    self.picker.datasource = self;
    _titlBar.titleLabel.text = @"请选择联系人";
}

-(void)loadView{
    [super loadView];
    [self tableView];
    [self picker];
    [self titlBar];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
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
        _tableView = [[UITableView alloc] initWithFrame:
                      CGRectMake(0, DEFAULT_TABLE_TOP, self.view.frame.size.width, self.view.frame.size.height-DEFAULT_TABLE_TOP)
                                                  style:UITableViewStylePlain];
        _tableView.allowsMultipleSelection = YES;
        _tableView.accessibilityLabel = @"reciverTabel";
        [self.view addSubview:_tableView];
        [_tableView release];
    }
    return _tableView;
}

-(ICRecipientPicker*)picker{
    if (!_picker) {
        _picker = [[ICRecipientPicker alloc] initWithFrame:CGRectMake(0, DEFAULT_PICKER_TOP, self.view.frame.size.width, DEFAULT_PICKER_HEIGHT)];
        _picker.selectionStyle = ICRecipientPickerSelectionStyleDefault;
        _picker.backgroundColor = [UIColor colorWithRed:240.0f/255.0f green:238.0f/255.0f blue:230.9f/255.0f alpha:1.0f];
        [self.view addSubview:_picker];
        [_picker release];
    }
    return _picker;
}

-(NSMutableArray*)selectedRecivers{
    if (!_selectedRecivers) {
        _selectedRecivers = [[NSMutableArray array] retain];
    }
    return _selectedRecivers;
}

#pragma mark - business method

-(BOOL)containReciver:(NSObject*)reciver{
    if ([self.selectedRecivers indexOfObject:reciver]==NSNotFound) {
        return NO;
    }
    return YES;
}

#pragma mark - ICRecipientPickerDataSource

-(ICRecipientPickerItem *)recipientPicker:(ICRecipientPicker*)pickerView itemForIndex:(NSInteger)index{
    Reciver* vo = [self.selectedRecivers objectAtIndex:index];
    ICRecipientPickerItem* item = [[ICRecipientPickerItem alloc] init];
    item.textLabel.text = vo.reciverName;
    item.object = vo;
    return item;
}

-(void)putItem:(NSObject*)item{
    if (![self containReciver:item]) {
        [self.selectedRecivers addObject:item];
        [self.picker insertItemAtIndex:-1 animated:YES];
    }
}

-(NSInteger)numberOfItemsInPikcerView:(ICRecipientPicker *)pickerView{
    return self.selectedRecivers.count;
}
@end
