//
//  ModalGroupController.h
//  ModalGroupContacts
//
//  Created by marco on 13-3-12.
//  Copyright (c) 2013年 marco. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SearchBar;

@interface ModalGroupController : UIViewController
@property(nonatomic, retain) SearchBar* titlBar;
@property(nonatomic, retain) UITableView* tableView;
@property(nonatomic, retain) NSMutableArray* selectedRecivers;
@end
