//
//  zHud.m
//  ZhuangBei
//
//  Created by aa on 2020/4/25.
//  Copyright © 2020 aa. All rights reserved.
//

#import "zHud.h"
#import "MBProgressHUD.h"
@interface zHud ()

@property(strong,nonatomic)MBProgressHUD *hud;

@end

@implementation zHud

+(zHud*)shareInstance
{
    static zHud *_zHud = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _zHud = [[super allocWithZone:NULL] init];
    });
    return _zHud;
}

-(UIWindow *)mainWindow
{
    UIApplication *app = [UIApplication sharedApplication];
    if ([app.delegate respondsToSelector:@selector(window)])
    {
        return [app.delegate window];
    }
    else
    {
        return [app keyWindow];
    }
}

-(MBProgressHUD*)hud
{
    if (!_hud) {
        
    }
    return _hud;
}

-(void)showMessage:(NSString*)message{
    UIView * view = [self mainWindow];
    self.hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    self.hud.mode = MBProgressHUDModeText;
    self.hud.label.text = message;
    [self.hud hideAnimated:YES afterDelay:2.f];
}

-(void)show{
     UIView * view = [self mainWindow];
     self.hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
     self.hud.mode = MBProgressHUDModeIndeterminate;
     self.hud.label.text = @"";
}

-(void)hild{
    
    [self.hud hideAnimated:YES];
}



@end
