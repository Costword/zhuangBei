//
//  UIImageView+LWImageView.m
//  ZhuangBei
//
//  Created by LWQ on 2020/5/6.
//  Copyright © 2020 aa. All rights reserved.
//

#import "UIImageView+LWImageView.h"
#import "zInterfacedConst.h"
#import "UIImage+LWSVGKit.h"
#import "SVGKImage.h"

@implementation UIImageView (LWImageView)


#pragma mark ----------------通过图片 id  加载图片----------------

/// 通过imageId加载图片
/// @param imageId 图片id
/// @param placeholderImage 站位图
- (void)z_imageWithImageId:(NSString *)imageId placeholderImage:(NSString *)placeholderImage
{
    if (!imageId && !placeholderImage) {
        return;
    }
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@app/appfujian/download?attID=%@",kApiPrefix,imageId]];
    if (placeholderImage) {
        [self z_sd_setImageWithURL:url placeholderImage:placeholderImage];
        
    }else{
        [self sd_setImageWithURL:url];
    }
}

/// 通过imageId加载图片   使用内部默认使用展位图
/// @param imageId 图片id
- (void)z_imageWithImageId:(NSString *)imageId
{
    [self z_imageWithImageId:imageId placeholderImage:@"placeholdericon.svg"];
}



#pragma mark ---------------- 通用的加载svg图片 尽量在布局代码后使用，内部需要用到self.size----------------

/// 获取svg格式图片
/// @param imageName svg图片名称
- (UIImage *)z_getImageWithSVG:(NSString *)imageName
{
    if (self.frame.size.width == 0 && self.frame.size.height == 0) {
        [self.superview layoutIfNeeded];
    }
    
    UIImage *img;
    if ([imageName hasSuffix:@".svg"]) {
        @try {
            //        防止找不到该占位图的路径造成的崩溃
            img = [UIImage svgImageNamed:imageName imgv:self];
        } @catch (NSException *exception) {
            
        } @finally {
            
        }
    }else{
        img = IMAGENAME(imageName);
    }
    return img;
}

/// 获取默认的占位svg图片
- (UIImage *)z_getPlaceholderImageWithSVG
{
    return [self z_getImageWithSVG:@"placeholdericon.svg"];
}

/// 加载网络图片
/// @param url 网络图片地址
/// @param placeholder svg占位图的名称
- (void)z_sd_setImageWithURL:(nullable NSURL *)url placeholderImage:(nullable NSString *)placeholder
{
    UIImage *img ;
    if (placeholder) {
         img = [self z_getImageWithSVG:placeholder];
    }

    if (img) {
        [self sd_setImageWithURL:url placeholderImage:img];
    }else{
        [self sd_setImageWithURL:url];
    }
}

/// 加载网络图片 自带默认svg占位图
/// @param url 网络图片地址
- (void)z_sd_setImageWithURLHaveDefaultPlaceHolderImage:(nullable NSURL *)url
{
    UIImage *img ;
    img = [self z_getImageWithSVG:@"placeholdericon.svg"];
    [self sd_setImageWithURL:url placeholderImage:img];
}



#pragma mark ---------------- 加载svg图片 如果使用上面的方式 加载出来，可以手动设置size ----------------

/// 根据图片id加载图片
/// @param imageId 图片id
/// @param imgSize 图片大小
- (void)z_imageWithImageId:(NSString *)imageId imgSize:(CGSize)imgSize
{
    UIImage *img = [self z_imageWithSVG:@"placeholdericon" imgSize:imgSize];
   [self sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@app/appfujian/download?attID=%@",kApiPrefix,imageId]] placeholderImage:img];
}

/// 加载svg图片
/// @param imageName svg图名称
/// @param imgSize 图片大小
- (UIImage *)z_imageWithSVG:(NSString *)imageName imgSize:(CGSize)imgSize
{
    if (![imageName isNotBlank]) {
        return nil;
    }
    if (![imageName hasSuffix:@".svg"]) {
        imageName = [imageName stringByAppendingString:@".svg"];
    }
    SVGKImage *svgImage = [SVGKImage imageNamed:imageName];
    svgImage.size = imgSize;
    self.image = svgImage.UIImage;
    return svgImage.UIImage;
}
@end

