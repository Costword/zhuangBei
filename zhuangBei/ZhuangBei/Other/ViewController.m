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
    
//
//    UIImage *img = [UIImage ex_drawImage:IMAGENAME(@"testicon") size:CGSizeMake(10, 10) backgroundColor:UIColor.redColor];
//
//    tem.image = img;
    
    tem.image = [UIImage svgImageNamed:@"testicon" imgv:tem];
}


@end
