//
//  SelectorTableVIewDelegate.m
//  ModalGroupContacts
//
//  Created by marco on 13-3-13.
//  Copyright (c) 2013年 marco. All rights reserved.
//

#import "SelectorTableViewDelegate.h"
#import "ICMenuTableDatasource.h"
#import "MenuSectionReciverCell.h"
#import "ICMenuTableSection.h"
#import "ICRecipientPicker.h"

@implementation SelectorTableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        ICMenuTableSection* section = [self.ds.sections objectAtIndex:indexPath.section];
        [section reverseSection];
    }else{ // TODO: insert item to picker view.
        ICRecipientPicker* picker = (ICRecipientPicker*)self.floatHeaderView;
        NSObject<ICRecipientPickerDataSource>* pickerDataSource = picker.datasource;
        [picker insertItemAtIndex:-1 animated:YES];  // test ok.
        TTDPRINT(@"%@", pickerDataSource);
    }
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        ICMenuTableSection* section = [self.ds.sections objectAtIndex:indexPath.section];
        [section reverseSection];
    }
}


@end
