//
//  UIImageView+LWImageView.h
//  ZhuangBei
//
//  Created by LWQ on 2020/5/6.
//  Copyright © 2020 aa. All rights reserved.
//



#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImageView (LWImageView)

#pragma mark ----------------通过图片 id  加载图片----------------

/// 通过imageId加载图片
/// @param imageId 图片id
/// @param placeholderImage 站位图
- (void)z_imageWithImageId:(NSString *)imageId placeholderImage:(NSString *)placeholderImage;

/// 通过imageId加载图片   使用内部默认使用展位图
/// @param imageId 图片id
- (void)z_imageWithImageId:(NSString *)imageId;


#pragma mark ---------------- 通用的加载svg图片 尽量在布局代码后使用，内部需要用到self.size----------------

/// 获取默认的占位svg图片 (placeholdericon.svg)
- (UIImage *)z_getPlaceholderImageWithSVG;

/// 获取图片 (如果是png图片也可使用，svg图片需要添加后缀 eg: xxx.svg)
/// @param imageName 图片名称 
- (UIImage *)z_getImageWithSVG:(NSString *)imageName;

/// 加载网络图片 自带默认svg占位图
/// @param url 网络图片地址
- (void)z_sd_setImageWithURLHaveDefaultPlaceHolderImage:(nullable NSURL *)url;

/// 加载网络图片
/// @param url 网络图片地址
/// @param placeholder svg占位图的名称
- (void)z_sd_setImageWithURL:(nullable NSURL *)url placeholderImage:(nullable NSString *)placeholder;


#pragma mark ---------------- 加载svg图片 如果使用上面的方式 加载出来，可以手动设置size ----------------

/// 加载svg图片
/// @param imageName svg图名称
/// @param imgSize 图片大小
- (UIImage *)z_imageWithSVG:(NSString *)imageName imgSize:(CGSize)imgSize;

/// 根据图片id加载图片
/// @param imageId 图片id
/// @param imgSize 图片大小
- (void)z_imageWithImageId:(NSString *)imageId imgSize:(CGSize)imgSize;

@end

NS_ASSUME_NONNULL_END
