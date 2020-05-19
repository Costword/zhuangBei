//
//  zMyFriendListCell.m
//  ZhuangBei
//
//  Created by aa on 2020/5/19.
//  Copyright © 2020 aa. All rights reserved.
//

#import "zMyFriendListCell.h"



@interface zMyFriendListCell ()

@property(strong,nonatomic)UIImageView * imageHeader;

@property(strong,nonatomic)UIButton * nameButton;

@property(strong,nonatomic)UIButton * emailButton;

@property(strong,nonatomic)UIButton * phoneButton;

@end

@implementation zMyFriendListCell

+(zMyFriendListCell*)instanceWithTableView:(UITableView*)tableView AndIndexPath:(NSIndexPath*)indexPath
{
    static NSString * cellID = @"zMyFriendListCell";
    zMyFriendListCell * cell = [[zMyFriendListCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {

        [self updateConstraintsForView];
    }
    return self;
}

-(void)updateConstraintsForView
{

}

-(void)setSourceDic:(NSDictionary *)sourceDic
{
   
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    if (selected) {
       
    }else
    {
       
    }
}

@end


