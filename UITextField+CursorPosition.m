//
//  UITextField+CursorPosition.m
//  HYPlateNumberKeyboard
//
//  Created by 寰宇 on 2018/3/21.
//
// beginningOfDocument 和 endOfDocument 是text的头和末尾位置
// selectedTextRange 是光标框选的范围，就算没框选也是有值的
// 通过offsetFromPosition:toPosition:进行转换

#import "UITextField+CursorPosition.h"

@implementation UITextField(CursorPosition)

- (NSRange)selectedRange{
    NSInteger loc = [self offsetFromPosition:self.beginningOfDocument toPosition:self.selectedTextRange.start];
    NSInteger len = [self offsetFromPosition:self.selectedTextRange.start toPosition:self.selectedTextRange.end];
    
    return NSMakeRange(loc, len);
}

- (void)setSelectedRange:(NSRange)range {
    UITextPosition* startPosition = [self positionFromPosition:self.beginningOfDocument offset:range.location];
    UITextPosition* endPosition   = [self positionFromPosition:self.beginningOfDocument offset:range.location + range.length];
    
    UITextRange* selectionRange = [self textRangeFromPosition:startPosition toPosition:endPosition];
    
    [self setSelectedTextRange:selectionRange];
}

@end
