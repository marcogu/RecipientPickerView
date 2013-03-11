//
//  SearchBar.m
//  ModalGroupContacts
//
//  Created by marco on 13-3-10.
//  Copyright (c) 2013年 marco. All rights reserved.
//

#import "SearchBar.h"

@interface SearchBar()<UIGestureRecognizerDelegate>
{
    CAGradientLayer* _backgroundLayer;
    NSArray* _items;
    BOOL _isopen;
}
@property(nonatomic, retain) UIView* actionPickerView;
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
    [self titleLabel];
    _backgroundLayer = [self createBackgroundLayer];
    [self.actionPickerView.layer addSublayer:_backgroundLayer];
    UITapGestureRecognizer *tapGesture =
        [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleActionPickerViewTap:)];
    tapGesture.delegate = self;
    [self.actionPickerView addGestureRecognizer:tapGesture];
    [tapGesture release];
    _isopen = NO;
}

-(void)dealloc{
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
        _titleLabel.textColor = [UIColor blackColor];
        _titleLabel.shadowColor = [UIColor whiteColor];
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
		200.0f / 255.0f, 207.0f / 255.0f, 212.0f / 255.0f, 1.0f,
        169.0f / 255.0f, 178.0f / 255.0f, 185.0f / 255.0f, 1.0f
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

- (void)setItems:(NSArray *)newItems{
    if (_items != newItems) {
        for (UIView *subview in self.actionPickerView.subviews) {
            [subview removeFromSuperview];
        }
        
        [_items release];
        _items = [newItems copy];
        
        for (id item in _items) {
			if ([item isKindOfClass:[UIView class]]) {
				[self.actionPickerView addSubview:item];
			}
        }
    }
}

- (void)handleActionPickerViewTap:(UIGestureRecognizer *)gestureRecognizer {}

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
    __block __typeof__(self) blockSelf = self;
    [UIView animateWithDuration:0.2
        animations:^{
            blockSelf.actionPickerView.frame = CGRectMake(10.0f, 7.0f, blockSelf.frame.size.width - 20.0f, 30.0f);
            [blockSelf.titleLabel setAlpha:0.0f];
    }];
}

-(void)close{
    if (!_isopen) {
        return;
    }
    _isopen = NO;
    __block __typeof__(self) blockSelf = self;
    [UIView animateWithDuration:0.2
        animations:^{
            blockSelf.actionPickerView.frame = CGRectMake(blockSelf.frame.size.width - 40.0f, 7.0f, 30.0f, 30.0f);
            [blockSelf.titleLabel setAlpha:1.0f];
    }];
}


@end
