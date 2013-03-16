//
//  MemberVo.m
//  ModalGroupContacts
//
//  Created by marco on 13-3-12.
//  Copyright (c) 2013年 marco. All rights reserved.
//

#import "ReciverVo.h"

@implementation Reciver


+(NSArray*)getDemoDatas{
    Reciver* member = nil;
    
    Reciver* group1 = [[Reciver alloc] init];
    group1.r = [NSNumber numberWithInt:44];
    group1.g = [NSNumber numberWithInt:111];
    group1.b = [NSNumber numberWithInt:146];
    group1.reciverName = @"所有教师";
    group1.groupType = @"GroupNormal";
    group1.isGroup = YES;
    group1.memberList = [NSMutableArray array];
    
    Reciver* group2 = [[Reciver alloc] init];
    group2.r = [NSNumber numberWithInt:240];
    group2.g = [NSNumber numberWithInt:131];
    group2.b = [NSNumber numberWithInt:0];
    group2.reciverName = @"白雪公主和七个小矮人";
    group2.groupType = @"GroupNormal";
    group2.isGroup = YES;
    group2.memberList = [NSMutableArray array];
    
    member = [[Reciver alloc] init];
    member.avatar = @"http://oss.iclass.com/iclassbaby/50_50/1362030557582nzqzr.jpg";
    member.reciverName = @"iclass";
    member.reciverId = [NSNumber numberWithInt:1419];
    member.otherInfo = @"Teacher_1419_iclass";
    [group1.memberList addObject:member];
    [member release];

    member = [[Reciver alloc] init];
    member.avatar = @"http://oss.iclass.com/iclassbaby/50_50/1362030558065timls.jpg";
    member.reciverName = @"baby";
    member.reciverId = [NSNumber numberWithInt:1422];
    member.otherInfo = @"Teacher_1422_baby";
    [group1.memberList addObject:member];
    [member release];
    
    member = [[Reciver alloc] init];
    member.avatar = @"http://baby.iclass.com/public/img/userAvatar/50/ic_user.png";
    member.reciverName = @"和总";
    member.reciverId = [NSNumber numberWithInt:1433];
    member.otherInfo = @"Teacher_1433_和总";
    [group1.memberList addObject:member];
    [member release];
    
    member = [[Reciver alloc] init];
    member.avatar = @"http://baby.iclass.com/public/img/userAvatar/50/ic_user.png";
    member.reciverName = @"张燕";
    member.reciverId = [NSNumber numberWithInt:1434];
    member.otherInfo = @"Teacher_1434_张燕";
    [group1.memberList addObject:member];
    [member release];
    
    
    
    member = [[Reciver alloc] init];
    member.avatar = @"http://baby.iclass.com/public/img/userAvatar/50/ic_user.png";
    member.reciverName = @"成哲";
    member.reciverId = [NSNumber numberWithInt:1423];
    member.otherInfo = @"Teacher_1423_成哲";
    [group2.memberList addObject:member];
    [member release];
    
    member = [[Reciver alloc] init];
    member.avatar = @"http://baby.iclass.com/public/img/userAvatar/50/ic_user.png";
    member.reciverName = @"吴哥细";
    member.reciverId = [NSNumber numberWithInt:1417];
    member.otherInfo = @"Teacher_1417_吴哥细";
    [group2.memberList addObject:member];
    [member release];
    
    member = [[Reciver alloc] init];
    member.avatar = @"http://baby.iclass.com/public/img/userAvatar/50/ic_user.png";
    member.reciverName = @"徐玉珠";
    member.reciverId = [NSNumber numberWithInt:1415];
    member.otherInfo = @"Teacher_1415_徐玉珠";
    [group2.memberList addObject:member];
    [member release];
    
    
    NSArray* result = [NSArray arrayWithObjects:group1,group2, nil];
    [group1 release];
    [group2 release];
    return result;
}
@end
/*iclass baby logic */
/**
-(id)initWithDictionary:(NSDictionary*)dic{
    self = [super init];
    if (self) {
        self.reciverName = [dic objectForKey:@"groupName"];
        self.reciverId = [dic objectForKey: @"gid"];
        self.r=[dic objectForKey:@"r"];
        self.g=[dic objectForKey:@"g"];
        self.b=[dic objectForKey:@"b"];
        _isGroup = YES;
        self.otherInfo=[dic objectForKey:@"otherInfo"];
        self.roleWeight=[dic objectForKey:@"roleWeight"];
        
        _memberList=[[NSMutableArray array] retain];
        NSArray *dicMemberList=[dic objectForKey:@"memberList"];
        if (dicMemberList) {
            [dicMemberList enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                ReciverVo *memberVo=[[ReciverVo alloc] initMemberVoWithDic:obj];
                [_memberList addObject:memberVo];
                [memberVo release];
            }];
        }
    }
    return self;
}

-(id)initMemberVoWithDic:(NSDictionary*)dic{
    self.reciverName = [dic objectForKey:@"fullName"];
    self.reciverId = [dic objectForKey: @"mid"];
    self.avatar=[dic objectForKey:@"avatar"];
    self.otherInfo=[dic objectForKey:@"otherInfo"];
    self.roleWeight=[dic objectForKey:@"roleWeight"];
    
    _isGroup=NO;
    return  self;
}
*/

