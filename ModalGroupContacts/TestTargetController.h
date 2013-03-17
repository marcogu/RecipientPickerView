//
//  TestTargetController.h
//  ModalGroupContacts
//
//  Created by marco on 13-3-10.
//  Copyright (c) 2013年 marco. All rights reserved.
//

#import "ICRecipientPicker.h"

@class SearchBar;

@interface TestTargetController : UIViewController
{
    SearchBar* _titlBar;
}
@end


@interface PickDataSource : NSObject<ICRecipientPickerDataSource>
{
    NSMutableArray* _datas;
}
@end