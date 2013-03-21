//
//  SearchBar.m
//  ModalGroupContacts
//
//  Created by marco on 13-3-10.
//  Copyright (c) 2013年 marco. All rights reserved.
//

#import "SearchBar.h"
#import "ModalGroupController.h"

@interface SearchBar()<UIGestureRecognizerDelegate>
{
    CAGradientLayer* _backgroundLayer;
    NSArray* _items;
    UIButton* _searchBtn;
    UITextField* _searchInput;
    UIButton* _conformBtn;
    UITableView* _searchResultTable;
    BOOL _isopen;
}
@property(nonatomic, retain) UIView* actionPickerView;
@property(nonatomic, readonly) UIButton* searchBtn;
@property(nonatomic, readonly) UITextField* searchInput;
@property(nonatomic, readonly) UIButton* conformBtn;
@property(nonatomic, readonly) UITableView* searchResultTable;
@end

@implementation SearchBar

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (id)init
{
    self = [super initWithFrame:CGRectMake(0, 0, 320, 50)];
    if (self) {
        [self setup];
    }
    return self;
}

-(void)setup{
    self.backgroundColor = [UIColor clearColor];
    [self conformBtn];
    [self titleLabel];
    _backgroundLayer = [self createBackgroundLayer];
//    UITapGestureRecognizer *tapGesture =
//        [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleActionPickerViewTap:)];
//    tapGesture.delegate = self;
    [self.actionPickerView.layer addSublayer:_backgroundLayer];
//    [self.actionPickerView addGestureRecognizer:tapGesture];
    [self.actionPickerView addSubview:self.searchBtn];
    [self.actionPickerView addSubview:self.searchInput];
//    [tapGesture release];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keboardShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keboardHiden:) name:UIKeyboardWillHideNotification object:nil];
    
    _isopen = NO;
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [_titleLabel release];
    [_actionPickerView release];
    [_items release];
    [super dealloc];
}

-(UIView*)actionPickerView{
    if(!_actionPickerView){
        _actionPickerView = [[UIView alloc] initWithFrame:CGRectMake(self.frame.size.width - 40.0f, 7.0f, 30.0f, 30.0f)];
        _actionPickerView.layer.cornerRadius = 15.0f;
        _actionPickerView.layer.borderWidth = 1.0f;
        _actionPickerView.layer.borderColor = [UIColor darkGrayColor].CGColor;
        _actionPickerView.clipsToBounds = YES;
        [self addSubview:_actionPickerView];
    }
    return _actionPickerView;
}

-(UILabel*)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(100.0f, 12.0f, self.frame.size.width - 70.0f, 20.0f)];
        _titleLabel.font = [UIFont systemFontOfSize:18.0f];
        _titleLabel.numberOfLines = 0;
        _titleLabel.backgroundColor = [UIColor clearColor];
        _titleLabel.textColor = [UIColor whiteColor];
        _titleLabel.shadowColor = [UIColor grayColor];
        _titleLabel.shadowOffset = CGSizeMake(0.0f, 1.0f);
        _titleLabel.hidden = NO;
        _titleLabel.opaque = NO;
        [self addSubview:_titleLabel];
    }
    return _titleLabel;
}

-(CAGradientLayer*)createBackgroundLayer{
    CAGradientLayer* backgroundLayer = [CAGradientLayer layer];
	backgroundLayer.anchorPoint = CGPointMake(0.0f, 0.0f);
	backgroundLayer.position = CGPointMake(0.0f, 0.0f);
	backgroundLayer.startPoint = CGPointZero;
	backgroundLayer.endPoint = CGPointMake(0.0f, 1.0f);
	backgroundLayer.colors = [NSArray arrayWithObjects:(id)[UIColor grayColor].CGColor, (id)[UIColor darkGrayColor].CGColor, nil];
    backgroundLayer.bounds = CGRectMake(0.0f, 0.0f, self.frame.size.width - 20.0f, 30.0f);
    return backgroundLayer;
}

- (void)drawRect:(CGRect)rect {
    static CGFloat colors[] = { //content background color
		131.0f / 255.0f, 168.0f / 255.0f, 200.0f / 255.0f, 1.0f,
        39.0f / 255.0f, 92.0f / 255.0f, 150.0f / 255.0f, 1.0f        
	};
    [self drawLinearGradientInRect:CGRectMake(0.0f, 0.0f, rect.size.width, 44.0f) colors:colors];
    // bottom line board
    CGFloat line2[]={94.0f / 255.0f,  103.0f / 255.0f, 109.0f / 255.0f, 1.0f};
    [self drawLineInRect:CGRectMake(0.0f, 44.5f, rect.size.width, 0.0f) colors:line2];
    // shadow
    CGFloat colors2[] = {
        152.0f / 255.0f, 156.0f / 255.0f, 161.0f / 255.0f, 0.5f,
        152.0f / 255.0f, 156.0f / 255.0f, 161.0f / 255.0f, 0.1f
    };
    [self drawLinearGradientInRect:CGRectMake(0.0f, 45.0f, rect.size.width, 5.0f) colors:colors2];
}

- (void)drawLinearGradientInRect:(CGRect)rect colors:(CGFloat[])colours {
	CGContextRef context = UIGraphicsGetCurrentContext();
	CGContextSaveGState(context);
	
	CGColorSpaceRef rgb = CGColorSpaceCreateDeviceRGB();
	CGGradientRef gradient = CGGradientCreateWithColorComponents(rgb, colours, NULL, 2);
	CGColorSpaceRelease(rgb);
	CGPoint start, end;
	
	start = CGPointMake(rect.origin.x, rect.origin.y + rect.size.height * 0.25);
	end = CGPointMake(rect.origin.x, rect.origin.y + rect.size.height * 0.75);;
	
	CGContextClipToRect(context, rect);
	CGContextDrawLinearGradient(context, gradient, start, end, kCGGradientDrawsBeforeStartLocation | kCGGradientDrawsAfterEndLocation);
	
	CGGradientRelease(gradient);
	CGContextRestoreGState(context);
}

- (void)drawLineInRect:(CGRect)rect colors:(CGFloat[])colors {
	CGContextRef context = UIGraphicsGetCurrentContext();
	CGContextSaveGState(context);
	
	CGContextSetRGBStrokeColor(context, colors[0], colors[1], colors[2], colors[3]);
	CGContextSetLineCap(context, kCGLineCapButt);
	CGContextSetLineWidth(context, 1.0f);
	
	CGContextMoveToPoint(context, rect.origin.x, rect.origin.y);
	CGContextAddLineToPoint(context, rect.origin.x + rect.size.width, rect.origin.y + rect.size.height);
	CGContextStrokePath(context);
	CGContextRestoreGState(context);
}

//- (void)handleActionPickerViewTap:(UIGestureRecognizer *)gestureRecognizer {}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    for (UIView *subview in self.actionPickerView.subviews) {
        if (subview == touch.view && self.titleLabel.isHidden) {
            return NO;
        }
    }
    [self open];
    return YES;
}

- (void)shrinkActionPicker {
    self.titleLabel.hidden = NO;
    [self setNeedsLayout];
}

-(void)open{
    if (_isopen) {
        return;
    }
    _isopen = YES;
    [self.searchInput becomeFirstResponder];
//    __block __typeof__(self) blockSelf = self;
    [UIView animateWithDuration:0.2
        animations:^{
            _actionPickerView.frame = CGRectMake(10.0f, 7.0f, self.frame.size.width - 20.0f, 30.0f);
            [_titleLabel setAlpha:0.0f];
    }];
}

-(void)close{
    if (!_isopen) {
        return;
    }
    _isopen = NO;
    self.searchInput.text = nil;
    [self.searchInput resignFirstResponder];
//    __block __typeof__(self) blockSelf = self;
    [UIView animateWithDuration:0.2
        animations:^{
            _actionPickerView.frame = CGRectMake(self.frame.size.width - 40.0f, 7.0f, 30.0f, 30.0f);
            [_titleLabel setAlpha:1.0f];
    }];
}

-(void)reverseState{
    if (_isopen) {
        [self close];
    }else{
        [self open];
    }
}

-(UIButton*)searchBtn{
    if(!_searchBtn) {
        _searchBtn = [[UIButton buttonWithType:UIButtonTypeCustom] retain];
        [_searchBtn addTarget:self action:@selector(reverseState) forControlEvents:UIControlEventTouchUpInside];
        [_searchBtn setImage:[UIImage imageNamed:@"UIButtonBarSearch"] forState:UIControlStateNormal];
        _searchBtn.frame = CGRectMake(0.0f, 0.0f, 30.0f, 30.0f);
        _searchBtn.imageEdgeInsets = UIEdgeInsetsMake(3.0f, 3.0f, 3.0f, 3.0f);
        _searchBtn.center = CGPointMake(15.0f, 15.0f);
    }
    return _searchBtn;
}

-(UITextField*)searchInput{
    if (!_searchInput) {
        _searchInput = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, 265, 20)];
        _searchInput.font = [UIFont systemFontOfSize:14];
        _searchInput.textColor = [UIColor whiteColor];
        _searchInput.center = CGPointMake(168, 16.f);
        _searchInput.placeholder = @"请输入搜索的内容";
        _searchInput.autocorrectionType = UITextAutocorrectionTypeNo;
        _searchInput.clearButtonMode = UITextFieldViewModeAlways;
    }
    return _searchInput;
}
// here need three20. UI 
-(UIButton*)conformBtn{
    if (!_conformBtn) {
        _conformBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _conformBtn.frame = CGRectMake(15, 7, 40, 30);
        [_conformBtn addTarget:self action:@selector(btnConformClick) forControlEvents:UIControlEventTouchUpInside];
        [_conformBtn setTitle:@"确定" forState:UIControlStateNormal];
        [self addSubview:_conformBtn];
    }
    return _conformBtn;
}

-(UITableView*)searchResultTable{
    if (!_searchResultTable) {
        _searchResultTable = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
//        [self.superViewController addSearchResultTableBeSubView:_searchResultTable];
        [self.superViewController.view addSubview:_searchResultTable];
        _searchResultTable.dataSource = self;
        _searchResultTable.delegate = self;
    }
    return _searchResultTable;
}

-(void)btnConformClick{
    [self.superViewController.navigationController popViewControllerAnimated:YES];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    return nil;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    self.searchResultTable.frame = {};
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath NS_AVAILABLE_IOS(3_0){
//    self.searchResultTable.frame = {};
}

#pragma mark - notification center event handler.

-(void)keboardShow:(NSNotification *)note{
    if (_isopen) {
        CGRect keyboardBounds;
        [[note.userInfo valueForKey:UIKeyboardFrameEndUserInfoKey] getValue: &keyboardBounds];
        float bottom = self.frame.origin.y + self.frame.size.height;
        float height = self.superViewController.view.frame.size.height - keyboardBounds.size.height - self.frame.size.height;
        self.searchResultTable.frame = CGRectMake(0, bottom, self.frame.size.width, height);
    }
    
    /*
     
     NSNumber *duration = [note.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
     NSNumber *curve = [note.userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey];
     keyboardBounds = [self.view convertRect:keyboardBounds toView:nil];
     CGRect containerFrame = containerView.frame;
     containerFrame.origin.y = self.view.bounds.size.height - (keyboardBounds.size.height + containerFrame.size.height);
     
     [UIView beginAnimations:nil context:NULL];
     [UIView setAnimationBeginsFromCurrentState:YES];
     [UIView setAnimationDuration:[duration doubleValue]];
     [UIView setAnimationCurve:[curve intValue]];
     containerView.frame = containerFrame;
     _replyListTable.height = containerView.top;
     if (_replydataSource.items.count > 0) {
     NSIndexPath *lastRow = [NSIndexPath indexPathForRow:_replydataSource.items.count-1 inSection:0];
     [_replyListTable scrollToRowAtIndexPath:lastRow atScrollPosition:UITableViewScrollPositionBottom animated:NO];
     }
     [UIView commitAnimations];
     */
}

-(void)keboardHiden:(NSNotification *)note{
    self.searchResultTable.frame = CGRectZero;
}

@end
