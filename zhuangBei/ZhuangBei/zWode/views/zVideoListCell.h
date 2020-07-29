//
//  zVideoListCell.h
//  ZhuangBei
//
//  Created by aa on 2020/7/27.
//  Copyright © 2020 aa. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface zVideoListCell : UITableViewCell

+(zVideoListCell*)instanceWithTableView:(UITableView*)tableView AndIndexPath:(NSIndexPath*)indexPath;

@property(strong,nonatomic)NSDictionary * sourceDic;

@end

NS_ASSUME_NONNULL_END
