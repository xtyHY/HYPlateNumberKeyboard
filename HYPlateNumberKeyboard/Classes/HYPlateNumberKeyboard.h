//
//  HYPlateNumberKeyboard.h
//  PlateNumberKeyboard
//
//  Created by 寰宇 on 2018/3/19.
//

#import <UIKit/UIKit.h>
@class HYPlateNumberKeyboard;

/** 车牌号键盘Delegate方法 */
@protocol HYPlateNumberKeyboardDelegate<NSObject>
/** 用户改变了输入内容的时候就会回调此方法 */
- (void)HYPlateNumberKeyboard:(HYPlateNumberKeyboard *)keyboard
                   didChanged:(UITextField *)textfield;
@optional
/** 用户点击toolbar删除按钮时回调 */
- (void)HYPlateNumberKeyboard:(HYPlateNumberKeyboard *)keyboard
                  clickDelete:(UITextField *)textfield;
/** 用户点击toolbar关闭按钮时回调 */
- (void)HYPlateNumberKeyboard:(HYPlateNumberKeyboard *)keyboard
                   clickClose:(UITextField *)textfield;
@end

/** 车牌号键盘 */
@interface HYPlateNumberKeyboard : UIView

@property (nonatomic, strong, readonly) UIToolbar *toolBar; //!<键盘上方toolbar
@property (nonatomic, weak) UITextField *textfield; //!<输入框
@property (nonatomic, weak) id<HYPlateNumberKeyboardDelegate> delegate; //!<代理对象

/** 返回一个车牌号键盘单例对象 */
+ (instancetype)keyboard;

@end
