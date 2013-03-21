//
//  TestTargetController.m
//  ModalGroupContacts
//
//  Created by marco on 13-3-10.
//  Copyright (c) 2013年 marco. All rights reserved.
//

#import "TestTargetController.h"
#import "ModalGroupController.h"


@interface TestTargetController ()
{
    UIButton* _btnGotoTarget;
    ICRecipientPicker* _picker;
    UIButton* _btnNewReciver;
}
@property(nonatomic, readonly)UIButton* btnGotoTarget;
@property(nonatomic, readonly)UIButton* btnNewReciver;
@property(nonatomic, readonly)ICRecipientPicker* picker;
@end

@implementation TestTargetController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self btnGotoTarget];
    [self btnNewReciver];
    [self picker];
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

-(void)viewWillAppear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [super viewWillAppear:animated];
}

-(UIButton*)btnNewReciver{
    if (!_btnNewReciver) {
        _btnNewReciver = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        _btnNewReciver.frame = CGRectMake(self.btnGotoTarget.frame.size.width, 0, 0, 0);
        [_btnNewReciver setTitle:@"add reciver" forState:UIControlStateNormal];
        [_btnNewReciver addTarget:self action:@selector(addReciverTest) forControlEvents:UIControlEventTouchUpInside];
        [_btnNewReciver sizeToFit];
        [self.view addSubview:_btnNewReciver];
    }
    return _btnNewReciver;
}

-(ICRecipientPicker*)picker{
    if (!_picker) {
        float pickerY = self.btnGotoTarget.frame.origin.y+self.btnGotoTarget.frame.size.height;
        _picker = [[ICRecipientPicker alloc] initWithFrame:CGRectMake(0, pickerY, self.view.frame.size.width, 44)];
        _picker.datasource = [PickDataSource alloc];
        _picker.selectionStyle = ICRecipientPickerSelectionStyleDefault;
        _picker.backgroundColor = [UIColor underPageBackgroundColor];
        [self.view addSubview:_picker];
        [_picker release];
    }
    return _picker;
}

-(void)gotoTargetHandler{
    ModalGroupController* _targetController = [[ModalGroupController alloc] initWithNibName:nil bundle:nil];
    [self.navigationController pushViewController:_targetController animated:YES];
}

-(void)addReciverTest{
    [self.picker insertItemAtIndex:-1 animated:YES];
}
@end




@implementation PickDataSource
-(id)init{
    self = [super init];
    _datas = [[NSMutableArray alloc] init];
    return self;
}

-(void)dealloc{
    [_datas release];
    [super dealloc];
}

-(ICRecipientPickerItem *)recipientPicker:(ICRecipientPicker*)pickerView itemForIndex:(NSInteger)index{
    ICRecipientPickerItem* item = [[ICRecipientPickerItem alloc] init];
    item.textLabel.text = @"黄胜东";
    return item;
}
@end








