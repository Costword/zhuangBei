//
//  LWChatListViewController.h
//  ZhuangBei
//
//  Created by LWQ on 2020/5/14.
//  Copyright © 2020 aa. All rights reserved.
//

#import "IFBaseVC.h"
#import "LWClientHeader.h"
NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, LWChatRoomType) {
    LWChatRoomTypeOneTOne,  //一对一
    LWChatRoomTypeGroup,    //群组
};

@interface LWChatListBaseViewController : IFBaseVC

@property (nonatomic, strong) IFChatView *chatView;
@property (nonatomic, strong) NSString *roomName;
@property (nonatomic, strong) NSString * roomId;
@property (nonatomic, strong) NSMutableArray<ShowMsgElem *> *showDatasArray;

- (void)scrollTableToFoot:(BOOL)animated;

+ (instancetype)chatRoomViewControllerWithRoomId:(NSString *)roomId roomName:(NSString *)roomName roomType:(LWChatRoomType)roomType extend:(id)extend;

@end

NS_ASSUME_NONNULL_END
