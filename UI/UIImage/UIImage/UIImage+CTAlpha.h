// UIImage+CTAlpha.h
// Created by Trevor Harmon on 9/20/09.
// Free for personal or commercial use, with or without modification.
// No warranty is expressed or implied.

// Helper methods for adding an alpha layer to an image
#import <UIKit/UIKit.h>

@interface UIImage (Alpha)
- (BOOL)hasAlpha;
- (UIImage *)imageWithAlpha;
- (UIImage *)transparentBorderImage:(NSUInteger)borderSize;
-(UIImage *)imageWithShadow:(UIColor*)_shadowColor 
				 shadowSize:(CGSize)_shadowSize
					   blur:(CGFloat)_blur;

- (UIImage *)maskWithColor:(UIColor *)color;

- (UIImage *)maskWithColor:(UIColor *)color 
			   shadowColor:(UIColor *)shadowColor
			  shadowOffset:(CGSize)shadowOffset
				shadowBlur:(CGFloat)shadowBlur;


+ (UIImage *)imageFromColor:(UIColor *)color;
+ (UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)targetSize ;
- (UIImage *)imageWithTintColor:(UIColor *)tintColor;
- (UIImage*) getGrayImage;

- (UIImage *)useImage:(CGSize)scaleSize;

//修改图片透明度
- (UIImage *)imageWithAlphaComponent:(CGFloat)alpha;
@end
