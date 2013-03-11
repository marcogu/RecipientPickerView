//
//  SearchBar.h
//  ModalGroupContacts
//
//  Created by marco on 13-3-10.
//  Copyright (c) 2013年 marco. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

@interface SearchBar : UIView
{
    UILabel* _titleLabel;
}
@property(nonatomic, readonly) UILabel* titleLabel;
@property(nonatomic, copy) NSArray *items;
- (void)shrinkActionPicker;
- (void)close;
- (void)open;
@end
