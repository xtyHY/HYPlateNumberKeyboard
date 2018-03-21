//
//  UITextField+CursorPosition.h
//  HYPlateNumberKeyboard
//
//  Created by 寰宇 on 2018/3/21.
//

#import <UIKit/UIKit.h>

@interface UITextField(CursorPosition)

/** 获取当前textField框选范围的range */
- (NSRange)HY_selectedRange;

/** 通过range来设置textField框选范围 */
- (void)HY_setSelectedRange:(NSRange)range;

@end
