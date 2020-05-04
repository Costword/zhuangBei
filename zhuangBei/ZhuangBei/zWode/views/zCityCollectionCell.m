//
//  historyCollectionCell.m
//  guoziyunparent
//
//  Created by aa on 2019/7/19.
//  Copyright © 2019 xuxianwang. All rights reserved.
//

#import "zCityCollectionCell.h"

@interface zCityCollectionCell ()

@property (nonatomic, strong) UILabel *textlabel;

@end

@implementation zCityCollectionCell


- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.textlabel = [UILabel new];
        self.textlabel.frame = self.bounds;
        self.textlabel.font = [UIFont systemFontOfSize:13];
        self.textlabel.numberOfLines = 0;
        [self.contentView addSubview:self.textlabel];
        self.textlabel.textAlignment = NSTextAlignmentCenter;
        self.textlabel.textColor = [UIColor colorWithHexString:@"#333333"];
        self.textlabel.backgroundColor = [UIColor colorWithHexString:@"#F4F4F4"];
        [self.textlabel layoutIfNeeded];
    }
    return self;
}


- (void)layoutSubviews {
    [super layoutSubviews];
    self.textlabel.frame = self.bounds;
    
    [self clipCornerWithView:self.textlabel andTopLeft:YES andTopRight:YES andBottomLeft:YES andBottomRight:YES];
    
}


-(void)setSouceString:(NSString *)souceString
{
    self.textlabel.text = souceString;
}


- (UIView *)clipCornerWithView:(UIView *)originView
                    andTopLeft:(BOOL)topLeft
                   andTopRight:(BOOL)topRight
                 andBottomLeft:(BOOL)bottomLeft
                andBottomRight:(BOOL)bottomRight
{
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:originView.bounds
                                                   byRoundingCorners:(topLeft==YES ? UIRectCornerTopLeft : 0) |
                              (topRight==YES ? UIRectCornerTopRight : 0) |
                              (bottomLeft==YES ? UIRectCornerBottomLeft : 0) |
                              (bottomRight==YES ? UIRectCornerBottomRight : 0)
                                                         cornerRadii:CGSizeMake(0,0)];
    // 创建遮罩层
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = originView.bounds;
    maskLayer.path = maskPath.CGPath;   // 轨迹
    originView.layer.mask = maskLayer;
    
    return originView;
}

-(void)setBackColor:(UIColor *)backColor
{
    self.textlabel.backgroundColor = backColor;
}
@end
