# HYPlateNumberKeyboard

## 简介
用于输入车牌号的自定义键盘实现

## 样例
前往Exmaple目录，并执行`pod install`指令后打开项目

预览图：
![Exmaple-Gif](https://github.com/xtyHY/HYPlateNumberKeyboard/raw/master/keyboard.gif)

## 使用方式

### 配置键盘
```
// 初始化
self.keyboard = [HYPlateNumberKeyboard keyboard];

// 设置textField自定义键盘
self.textField.inputView = self.keyboard;
self.textField.inputAccessoryView = self.keyboard.toolBar;
[self.textField reloadInputViews];

// 将textField传递给键盘对象
self.keyboard.textfield = self.textField;

// 设置delegate
self.keyboard.delegate = self;
```

### 代理方法
```
- (void)HYPlateNumberKeyboard:(HYPlateNumberKeyboard *)keyboard
                   didChanged:(UITextField *)textfield {
    NSLog(@"Keyboard----->Changed: %@", textfield.text);
}

- (void)HYPlateNumberKeyboard:(HYPlateNumberKeyboard *)keyboard
                   clickClose:(UITextField *)textfield {
    NSLog(@"Keyboard----->Close: %@", textfield.text);
}

- (void)HYPlateNumberKeyboard:(HYPlateNumberKeyboard *)keyboard
                   clickDelete:(UITextField *)textfield {
    NSLog(@"Keyboard----->Delete: %@", textfield.text);
}
```

### 更新记录

- v 0.2.0
	根据光标位置输入
	挪动光标切换省份和字母键盘
	当已输入省份时，再次输入会进行替换
- v 0.1.0
	支持车牌号输入的自定义键盘，仅支持从头至尾顺序输入


