//
//  ICRecipientPicker.h
//  ModalGroupContacts
//
//  Created by marco on 13-3-16.
//  Copyright (c) 2013年 marco. All rights reserved.
//

#import "ICRecipientPickerItem.h"

typedef enum
{
    ICRecipientPickerSelectionStyleDefault,
    ICRecipientPickerSelectionStyleNone
}ICRecipientPickerSelectionStyle;

@protocol ICRecipientPickerDataSource;

@interface ICRecipientPicker : UIScrollView<ICRecipientPickerItemDelegate>
{
    NSMutableArray* _items;
}
@property(nonatomic, assign) NSObject<ICRecipientPickerDataSource>* datasource;
@property (nonatomic, assign) CGFloat itemPadding;
@property (nonatomic, assign) CGFloat itemHeight;
@property (nonatomic, assign) ICRecipientPickerItem* activeItem;
@property (nonatomic, assign) ICRecipientPickerSelectionStyle selectionStyle;

-(void)insertItemAtIndex:(NSInteger)index animated:(BOOL)animated;
@end

@protocol ICRecipientPickerDataSource <NSObject>
//-(NSInteger)numberOfItemsInBubbleView:(HEBubbleView *)bubbleView;
-(ICRecipientPickerItem *)recipientPicker:(ICRecipientPicker*)pickerView itemForIndex:(NSInteger)index;
-(void)putItem:(NSObject*)item;
@end
