//
//  ViewController.m
//  ZhuangBei
//
//  Created by aa on 2020/4/21.
//  Copyright © 2020 aa. All rights reserved.
//

#import "ViewController.h"
#import "UIImage+Extension.h"
#import "UIImage+LWSVGKit.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIImageView *tem = [[UIImageView alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    [self.view addSubview:tem];
    tem.backgroundColor = UIColor.greenColor;
    UIImage *img = [UIImage svgImageNamed:@"bq.svg" imgv:tem];
    tem.image = img;
    
    
    UIImageView *tem1 = [[UIImageView alloc] init];
    [self.view addSubview:tem1];
//    tem1.backgroundColor = UIColor.greenColor;
//    tem1.image = [UIImage svgImageNamed:@"placeholdericon.svg" imgv:tem1];
//    [tem1 z_imageWithSVG:@"placeholdericon.svg"];
    [tem1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.centerY.mas_equalTo(self.view.mas_centerY);
        make.width.height.mas_offset(200);
    }];
    
}


@end
