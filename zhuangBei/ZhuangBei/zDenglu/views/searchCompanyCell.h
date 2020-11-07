//
//  searchCompanyCell.h
//  ZhuangBei
//
//  Created by 王明辉 on 2020/11/6.
//  Copyright © 2020 aa. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface searchCompanyCell : UITableViewCell

+(searchCompanyCell*)creatTableViewCellWithTableView:(UITableView*)tableView AndIndexPath:(NSIndexPath*)indexPath;

@property(strong,nonatomic)NSDictionary * sourceDic;

@end

NS_ASSUME_NONNULL_END
